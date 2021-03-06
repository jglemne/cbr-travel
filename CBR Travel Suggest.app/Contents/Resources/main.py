#!/usr/local/bin/python3.5

import operator
from geopy.distance import great_circle
import tkinter as tk
import tkinter.font as tkFont
import tkinter.ttk as ttk
import tkinter.messagebox
from globals import fields_global, drop_downs_global, algorithm
from tools import *
from features import *
import heapq


def main():
    App.create().mainloop()


#  This class creates an instance of the case list visible in the gui-app
class CaseList:

    def __init__(self, nr_of_results, root):
        self.root = root
        self.tree = None
        self.selected_case = None
        self.setup()
        self.build_tree(nr_of_results, root)

    #  setup for the widgets
    def setup(self):
        container = ttk.Frame()
        container.pack(fill='both', expand=True, padx=(10, 10), pady=(10, 10))
        self.tree = ttk.Treeview(columns=SourceCase.list, show="headings")
        vsb = ttk.Scrollbar(orient="vertical", command=self.tree.yview)
        hsb = ttk.Scrollbar(orient="horizontal", command=self.tree.xview)
        self.tree.configure(yscrollcommand=vsb.set, xscrollcommand=hsb.set)
        self.tree.grid(column=0, row=0, sticky='nsew', in_=container)
        vsb.grid(column=1, row=0, sticky='ns', in_=container)
        hsb.grid(column=0, row=1, sticky='ew', in_=container)
        container.grid_columnconfigure(0, weight=1)
        container.grid_rowconfigure(0, weight=1)
        self.tree.bind("<Key>", self.selection)
        self.tree.bind("<ButtonRelease-1>", self.selection)

    #  building the list of cases
    def build_tree(self, nr_of_results, root):
        for col in SourceCase.list:
            self.tree.heading(col, text=col, command=lambda c=col: sort_by(self.tree, c, 0))
            # adjust the column's width to the header string, hotel column widened
            if col == 'Hotel name':
                self.tree.column(col, width=tkFont.Font().measure(col) * 3)
            else:
                self.tree.column(col, width=tkFont.Font().measure(col))
        results = SourceCase.fprs(root.target_case) if algorithm['fast'] else SourceCase.knn(root.target_case)
        if len(results) < nr_of_results:
            nr_of_results = len(results)
        for item in results[0:nr_of_results]:
            self.tree.insert('', 'end', values=item[0].case_tuples)

    #  when a case is selected in the list, editing and deleting is made possible
    #  and the selected case is identified
    def selection(self, event):
        self.root.case_buttons_state("normal")
        if event.type == '5':  # mouse click
            item_id = self.tree.identify_row(event.y)
            self.selected_case = SourceCase.codes[self.tree.item(item_id)["values"][1]]
        elif event.type == '2':
            if (event.keycode == 8320768) & (self.tree.prev(self.tree.focus()) != ''):  # up-button
                item_id = self.tree.prev(self.tree.focus())
                self.selected_case = SourceCase.codes[self.tree.item(item_id)["values"][1]]
            elif (event.keycode == 8255233) & (self.tree.next(self.tree.focus()) != ''):  # down-button
                item_id = self.tree.next(self.tree.focus())
                self.selected_case = SourceCase.codes[self.tree.item(item_id)["values"][1]]
            else:
                pass
        else:
            pass

    def get_selected_case(self):
        return self.selected_case

    case = property(get_selected_case)


#  This class creates an instance of an input field in the gui-app
class Field:
    fields = {}

    @classmethod
    def create(cls, master, label_text, row, col, default_value=None):
        instance = Field(master, label_text, row, col, default_value)
        cls.fields[label_text] = instance
        return instance

    def __init__(self, master, label_text, row, col, default_value=None):
        self.label = tk.Label(master, text=label_text)
        self.entry = tk.Entry(master)
        if default_value is not None:
            self.entry.insert(tk.END, default_value)
        self.row = row
        self.col = col

    def make_grid(self):
        self.label.grid(row=self.row, sticky=tk.E)
        self.entry.grid(row=self.row, column=self.col)

    def get_input(self):
        return self.entry.get()

    input = property(get_input)


#  This class creates an instance of an dropdown selection field in the gui-app
class DropDown:
    drop_downs = {}

    @classmethod
    def create(cls, master, label_text, row, col, default_value=None):
        instance = DropDown(master, label_text, row, col, default_value)
        cls.drop_downs[label_text] = instance
        return instance

    def __init__(self, master, label_text, row, col, default_value=None):
        self.var = tk.StringVar(master)
        self.label = tk.Label(master, text=label_text)
        if default_value is not None:
            variable = tk.StringVar(master)
            variable.set(default_value)
            self.entry = tk.OptionMenu(master, self.var, variable.get(), *drop_downs_global[label_text])
        else:
            self.entry = tk.OptionMenu(master, self.var, *drop_downs_global[label_text])
        self.row = row
        self.col = col

    def make_grid(self):
        self.label.grid(row=self.row, sticky=tk.E)
        self.entry.grid(row=self.row, column=self.col, sticky=tk.EW)

    def get_input(self):
        return self.var.get()

    input = property(get_input)


#  This class creates an instance of the menu seen in the gui-app
class Menu:

    def __init__(self, master):
        self.root = tk.Menu(master)
        # 'Case Base'
        self.cb_menu = tk.Menu(self.root, tearoff=0)
        # self.cb_menu.add_command(label="Show case base")
        self.cb_menu.add_command(
            label="Add new case",
            command=master.add_case_window
        )
        self.cb_menu.add_command(
            state="disabled",
            label="Edit selected case",
            command=master.edit_case_window
        )
        self.cb_menu.add_command(
            state="disabled",
            label="Delete selected case",
            command=master.delete_case_message
        )
        self.root.add_cascade(label="Case Base", menu=self.cb_menu)
        # 'Similarities'
        self.sim_menu = tk.Menu(self.root, tearoff=0)
        if algorithm['fast']:
            self.sim_name = "Switch to kNN"
        else:
            self.sim_name = "Switch to FPRS"
        self.sim_menu.add_command(label=self.sim_name, command=master.set_algorithm)
        self.key_state = 'normal' if algorithm['fast'] else 'disabled'
        self.sim_menu.add_command(
            label="Edit number of keys",
            state=self.key_state,
            command=master.keys_window
        )
        self.sim_menu.add_command(label="Edit weights", command=master.weights_window)
        self.root.add_cascade(label="Similarities", menu=self.sim_menu)
        # Configure the menu
        master.config(menu=self.root)

    def callback(self):
        pass


# This class creates an instance of the gui-app
class App(tk.Tk):
    field_row = 0
    field_column = 1
    entries = {}
    nr_of_results = 100
    edit_entries = {}
    weight_entries = {}

    @classmethod
    def create(cls):
        #  creates the necessary class instances for running the application
        weights = Weights()
        target_case = TargetCase(weights=weights)
        instance_cases(retrieve_cases(), target_case, weights)
        instance = App(target_case, weights)
        return instance

    def __init__(self, target_case, weights):
        tk.Tk.__init__(self)
        self.target_case = target_case
        self.weights = weights
        self.title('CBR Travel Suggest')
        self.window = None
        self.message_box = None
        self.key_entry = None
        self.menu = Menu(self)
        welcome = "Welcome \n" \
            "This system is designed to give you journey suggestions based " \
            "on your preferences. When you edit your preferences here below and then press " \
            "the button 'Get best matches', the system will compare your preferences with a " \
            "number of cases and bring you the best matches according to similarity calculated in percent.\n\n " \
            "If you want more info, edit similarity metrics and/or help, please use the menu elements."
        self.msg = ttk.Label(
            relief=tk.RIDGE,
            wraplength="8i",
            justify="center",
            anchor="n",
            padding=(10, 10, 10, 10),
            text=welcome
        )
        self.msg.pack(fill='x')
        self.field_frame = tk.Frame(self)
        self.field_frame.pack(side=tk.TOP, pady=(10, 0))
        for field in fields_global:
            self.entries[field] = Field.create(
                self.field_frame,
                field,
                self.field_row,
                self.field_column
            )
            self.entries[field].make_grid()
            self.field_row += 1
        for drop_down in drop_downs_global:
            self.entries[drop_down] = DropDown.create(
                self.field_frame,
                drop_down,
                self.field_row,
                self.field_column
            )
            self.entries[drop_down].make_grid()
            self.field_row += 1
        self.field_row = 0
        self.button = tk.Button(
            self.field_frame,
            text="Get best matches",
            command=self.get_best_matches)
        self.button.grid(columnspan=2, pady=(10, 0))
        self.list = CaseList(self.nr_of_results, self)
        self.button_frame = tk.Frame(self)
        self.button_frame.pack()
        self.ec_button = tk.Button(
            self.button_frame,
            text="Edit case",
            state=tk.DISABLED,
            command=self.edit_case_window
        )
        self.ec_button.pack(side=tk.LEFT, pady=(10, 10), padx=(10, 10))
        self.dc_button = tk.Button(
            self.button_frame,
            text="Delete case",
            state=tk.DISABLED,
            command=self.delete_case_message
        )
        self.dc_button.pack(side=tk.RIGHT, pady=(10, 10), padx=(10, 10))
        self.status_text = tk.StringVar()
        self.status_text.set("Using FPRS" if algorithm['fast'] else "Using brute force k-NN")
        self.status = ttk.Label(
            justify="left",
            padding=(10, 2, 10, 2),
            textvariable=self.status_text,
            relief=tk.RAISED
        )
        self.status.pack(side=tk.BOTTOM, fill='x')

    #  Whenever the conditions have changed for finding similar cases,
    #  this function is called
    def get_best_matches(self):
        self.list.tree.delete(*self.list.tree.get_children())
        self.case_buttons_state("disabled")
        for entry in self.entries:
            set_target_case_feature(entry, self.entries[entry].input, self.target_case)
        self.list.build_tree(self.nr_of_results, self)
        self.status_text.set("Using FPRS" if algorithm['fast'] else "Using brute force k-NN")

    #  change buttons if possible to edit/delete or not
    def case_buttons_state(self, state):
        self.dc_button.config(state=state)
        self.ec_button.config(state=state)
        self.menu.cb_menu.entryconfig("Edit selected case", state=state)
        self.menu.cb_menu.entryconfig("Delete selected case", state=state)

    #  creates and opens the window where the user can add a case to the case-base
    def add_case_window(self):
        self.window = tk.Toplevel(self)
        self.edit_entries = {}
        self.window.field_frame = tk.Frame(self.window)
        self.window.field_frame.pack(side=tk.TOP, pady=(10, 0))
        for field in fields_global:
            self.edit_entries[field] = Field.create(
                self.window.field_frame,
                field,
                self.field_row,
                self.field_column
            )
            self.edit_entries[field].make_grid()
            self.field_row += 1
        for drop_down in drop_downs_global:
            self.edit_entries[drop_down] = DropDown.create(
                self.window.field_frame,
                drop_down,
                self.field_row,
                self.field_column
            )
            self.edit_entries[drop_down].make_grid()
            self.field_row += 1
        self.field_row = 0
        self.window.button_frame = tk.Frame(self.window)
        self.window.button_frame.pack(side=tk.BOTTOM)
        self.window.cancel_button = tk.Button(
            self.window.button_frame,
            text="Cancel",
            state=tk.NORMAL,
            command=self.window.destroy
        )
        self.window.cancel_button.pack(side=tk.LEFT, pady=(10, 10), padx=(10, 10))
        self.window.apply_button = tk.Button(
            self.window.button_frame,
            text="Add to case base",
            state=tk.NORMAL,
            command=lambda: self.add_case()
        )
        self.window.apply_button.pack(side=tk.RIGHT, pady=(10, 10), padx=(10, 10))

    #  extracting information from the form to create a source case instance
    def add_case(self):
        self.list.tree.delete(*self.list.tree.get_children())
        self.case_buttons_state("disabled")
        new_case = fixed_list(12)
        for entry in self.edit_entries:
            if entry == 'Number of persons':
                new_case[5] = self.edit_entries[entry].input
            elif entry == 'Season':
                new_case[9] = self.edit_entries[entry].input
            elif entry == 'Region':
                new_case[6] = self.edit_entries[entry].input
            elif entry == 'Price':
                new_case[4] = self.edit_entries[entry].input
            elif entry == 'Hotel':
                new_case[11] = self.edit_entries[entry].input
            elif entry == 'Accommodation':
                new_case[10] = self.edit_entries[entry].input
            elif entry == 'Holiday type':
                new_case[3] = self.edit_entries[entry].input
            elif entry == 'Transportation':
                new_case[7] = self.edit_entries[entry].input
            elif entry == 'Duration':
                new_case[8] = self.edit_entries[entry].input
            else:
                pass
        new_case[1] = 'Journey' + str(SourceCase.max_code)
        new_case[0] = SourceCase.max_code
        new_case[2] = ''
        cases_to_create = [new_case]
        instance_cases(cases_to_create, self.target_case)
        self.list.build_tree(self.nr_of_results, self)
        self.edit_entries = {}
        self.window.destroy()

    #  creates and opens the window where the user can edit a case in the case-base
    def edit_case_window(self):
        case = self.list.case
        self.window = tk.Toplevel(self)
        self.edit_entries = {}
        self.window.field_frame = tk.Frame(self.window)
        self.window.field_frame.pack(side=tk.TOP, pady=(10, 0))
        for field in fields_global:
            self.edit_entries[field] = Field.create(
                self.window.field_frame,
                field,
                self.field_row,
                self.field_column,
                case.features[field]
            )
            self.edit_entries[field].make_grid()
            self.field_row += 1
        for drop_down in drop_downs_global:
            self.edit_entries[drop_down] = DropDown.create(
                self.window.field_frame,
                drop_down,
                self.field_row,
                self.field_column,
                case.features[drop_down]
            )
            self.edit_entries[drop_down].make_grid()
            self.field_row += 1
        self.field_row = 0
        self.window.button_frame = tk.Frame(self.window)
        self.window.button_frame.pack(side=tk.BOTTOM)
        self.window.cancel_button = tk.Button(
            self.window.button_frame,
            text="Cancel",
            state=tk.NORMAL,
            command=self.window.destroy
        )
        self.window.cancel_button.pack(side=tk.LEFT, pady=(10, 10), padx=(10, 10))
        self.window.apply_button = tk.Button(
            self.window.button_frame,
            text="Apply changes",
            state=tk.NORMAL,
            command=lambda: self.edit_case(case)
        )
        self.window.apply_button.pack(side=tk.RIGHT, pady=(10, 10), padx=(10, 10))

    #  extracting information from the form to edit a source case instance
    def edit_case(self, case):
        self.list.tree.delete(*self.list.tree.get_children())
        self.case_buttons_state("disabled")
        for entry in self.edit_entries:
            set_target_case_feature(entry, self.edit_entries[entry].input, case)
        self.list.build_tree(self.nr_of_results, self)
        self.edit_entries = {}
        self.window.destroy()

    #  creates a message box to confirm deletion of a source case
    def delete_case_message(self):
        answer = tkinter.messagebox.askquestion(
            'Delete case',
            'Are you sure you want to delete case ' + str(self.list.case.journey_code.number) + '?'
        )
        if answer == 'yes':
            case = self.list.case
            case.delete_case()
            self.get_best_matches()

    #  sets which algorithm is used to retrieve all cases
    def set_algorithm(self):
        text = 'brute force k-NN' if algorithm['fast'] else 'FPRS'
        answer = tkinter.messagebox.askquestion(
            'Set algorithm',
            'Are you sure you want to switch to ' + text + '?'
        )
        if answer == 'yes':
            algorithm['fast'] = not algorithm['fast']
            self.menu.sim_name = 'Switch to brute force k-NN' if algorithm['fast'] else 'Switch to FPRS'
            self.menu.sim_menu.entryconfigure(0, label=self.menu.sim_name)
            self.get_best_matches()
            algorithm_state = 'normal' if algorithm['fast'] else 'disabled'
            self.menu.sim_menu.entryconfig("Edit number of keys", state=algorithm_state)

    #  creates and opens the window for edit all the feature weights
    def weights_window(self):
        self.window = tk.Toplevel(self)
        self.weight_entries = {}
        self.window.field_frame = tk.Frame(self.window)
        self.window.field_frame.pack(side=tk.TOP, pady=(10, 0))
        for weight in self.weights.integers:
            self.weight_entries[weight] = Field.create(
                self.window.field_frame,
                weight,
                self.field_row,
                self.field_column,
                self.weights.integers[weight]
            )
            self.weight_entries[weight].make_grid()
            self.field_row += 1
        self.field_row = 0
        self.window.button_frame = tk.Frame(self.window)
        self.window.button_frame.pack(side=tk.BOTTOM)
        self.window.cancel_button = tk.Button(
            self.window.button_frame,
            text="Cancel",
            state=tk.NORMAL,
            command=self.window.destroy
        )
        self.window.cancel_button.pack(side=tk.LEFT, pady=(10, 10), padx=(10, 10))
        self.window.apply_button = tk.Button(
            self.window.button_frame,
            text="Apply changes",
            state=tk.NORMAL,
            command=self.edit_weights
        )
        self.window.apply_button.pack(side=tk.RIGHT, pady=(10, 10), padx=(10, 10))

    #  extracts the information given for editing weights and performs the changes
    def edit_weights(self):
        for weight in self.weight_entries:
            entry = self.weight_entries[weight]
            if self.weight_entries[weight] != '':
                self.weights.integers[weight] = int(entry.input)
        self.weights.set_weights()
        self.get_best_matches()
        self.window.destroy()
        self.weight_entries = {}

    #  creates and opens the window for edit number of key cases considered when using fprs
    def keys_window(self):
        self.window = tk.Toplevel(self)
        self.window.key_frame = tk.Frame(self.window)
        self.window.key_frame.pack(side=tk.TOP, pady=(10, 0))
        self.key_entry = Field.create(
            self.window.key_frame,
            'Current nr of key cases',
            self.field_row,
            self.field_column,
            algorithm['key cases']
        )
        self.key_entry.make_grid()
        self.field_row = 0
        self.window.button_frame = tk.Frame(self.window)
        self.window.button_frame.pack(side=tk.BOTTOM)
        self.window.cancel_button = tk.Button(
            self.window.button_frame,
            text="Cancel",
            state=tk.NORMAL,
            command=self.window.destroy
        )
        self.window.cancel_button.pack(side=tk.LEFT, pady=(10, 10), padx=(10, 10))
        self.window.apply_button = tk.Button(
            self.window.button_frame,
            text="Apply changes",
            state=tk.NORMAL,
            command=self.edit_keys
        )
        self.window.apply_button.pack(side=tk.RIGHT, pady=(10, 10), padx=(10, 10))

    #  change the number of key cases that will be considered
    def edit_keys(self):
        algorithm['key cases'] = int(self.key_entry.input)
        self.get_best_matches()
        self.window.destroy()
        self.key_entry = None


# This class creates an instance of the target case
class TargetCase:

    def __init__(
            self, weights=None, case=None, journey_code=None, holiday_type=None,
            price=None, number_of_persons=None, region=None, transportation=None,
            duration=None, season=None, accommodation=None, hotel=None):
        # all the feature classes here below can be found in features.py
        self.weights = weights
        self.accommodation = Accommodation(accommodation)
        self.case = case
        self.duration = Duration(duration)
        self.holiday_type = HolidayType(holiday_type)
        self.hotel = Hotel(hotel)
        self.journey_code = JourneyCode(journey_code)
        self.number_of_persons = NumberOfPersons(number_of_persons)
        self.price = Price(price, number_of_persons)
        self.region = Region(region)
        self.season = Season(season)
        self.transportation = Transportation(transportation)

    #  used as a resource to quickly get all the information about the target case
    def get_case_list(self):
        return [
            self.case,
            self.journey_code.number,
            self.holiday_type.name,
            self.price.total,
            self.number_of_persons.total,
            self.region.name,
            self.transportation.name,
            self.duration.days,
            self.season.month,
            self.accommodation.name,
            self.hotel.name
        ]

    #  Here below some resource methods are defined as properties
    #  to easily access, delete and edit all the individual features of the target case
    #
    def get_accommodation(self):
        return self.accommodation.name

    def set_accommodation(self, accommodation):
        self.accommodation = Accommodation(accommodation)

    def del_accommodation(self):
        del self.accommodation
        self.accommodation = Accommodation()

    def get_case(self):
        return self.case

    def set_case(self, case):
        self.case = case

    def del_case(self):
        del self.case

    def get_duration(self):
        return self.duration.days

    def set_duration(self, duration):
        self.duration = Duration(duration)

    def del_duration(self):
        del self.duration
        self.duration = Duration()

    def get_holiday_type(self):
        return self.holiday_type.name

    def set_holiday_type(self, holiday_type):
        self.holiday_type = HolidayType(holiday_type)

    def del_holiday_type(self):
        del self.holiday_type
        self.holiday_type = HolidayType()

    def get_hotel(self):
        return self.hotel.name

    def set_hotel(self, hotel):
        self.hotel = Hotel(hotel)

    def del_hotel(self):
        del self.hotel
        self.hotel = Hotel()

    def get_journey_code(self):
        return self.journey_code.number

    def set_journey_code(self, journey_code):
        self.journey_code = JourneyCode(journey_code)

    def del_journey_code(self):
        del self.journey_code
        self.journey_code = JourneyCode()

    def get_number_of_persons(self):
        return self.number_of_persons.total

    def set_number_of_persons(self, number_of_persons):
        self.number_of_persons = NumberOfPersons(number_of_persons)

    def del_number_of_persons(self):
        del self.number_of_persons
        self.number_of_persons = NumberOfPersons()

    def get_price(self):
        return self.price.total

    def set_price(self, price):
        if self.number_of_persons is not None:
            self.price = Price(price, self.number_of_persons.total)
        else:
            self.price = Price(price)

    def del_price(self):
        del self.price
        self.price = Price()

    def get_region(self):
        return self.region.name

    def set_region(self, region):
        self.region = Region(region)

    def del_region(self):
        del self.region
        self.region = Region()

    def get_season(self):
        return self.season.month

    def set_season(self, season):
        self.season = Season(season)

    def del_season(self):
        del self.season
        self.season = Season()

    def get_transportation(self):
        return self.transportation.name

    def set_transportation(self, transportation):
        self.transportation = Transportation(transportation)

    def del_transportation(self):
        del self.transportation
        self.transportation = Transportation()

    list = property(get_case_list)
    a = property(get_accommodation, set_accommodation, del_accommodation)
    c = property(get_case, set_case, del_case)
    d = property(get_duration, set_duration, del_duration)
    ht = property(get_holiday_type, set_holiday_type, del_holiday_type)
    h = property(get_hotel, set_hotel, del_hotel)
    jc = property(get_journey_code, set_journey_code, del_journey_code)
    nop = property(get_number_of_persons, set_number_of_persons, del_number_of_persons)
    p = property(get_price, set_price, del_price)
    r = property(get_region, set_region, del_region)
    s = property(get_season, set_season, del_season)
    t = property(get_transportation, set_transportation, del_transportation)


# This class creates an instance of a source case
class SourceCase(TargetCase):
    #  some useful class parameters
    cases = {}
    holiday_types = {
        'Active': 'Active', 'City': 'City', 'Education': 'Education', 'Recreation': 'Recreation',
        'Shopping': 'Shopping', 'Language': 'Language', 'Bathing': 'Bathing', 'Wandering': 'Wandering',
        'Adventure': 'Adventure', 'Diving': 'Diving', 'Skiing': 'Skiing', 'Surfing': 'Surfing'
    }
    price_range = [239, 8007]
    durations = []
    accommodations = {
        'HolidayFlat': 'HolidayFlat',
        'OneStar': 'OneStar',
        'TwoStars': 'TwoStars',
        'ThreeStars': 'ThreeStars',
        'FourStars': 'FourStars',
        'FiveStars': 'FiveStars'
    }
    hotels = {}
    regions = {}
    seasons = {}
    codes = {}
    transportations = {}
    max_code = 1470
    key_cases = {}
    list = [
        'Similarity [%]',
        'Case [index]',
        'Holiday type',
        'Price [€]',
        'Persons [#]',
        'Region in the world',
        'Transport',
        'Duration [days]',
        'Season [month]',
        'Accommodation type',
        'Hotel name'
        ]

    @classmethod
    def create(
            cls, weights, case, journey_code, holiday_type,
            price, number_of_persons, region, transportation,
            duration, season, accommodation, hotel, target_case):
        #  adding information to the class parameters
        if cls.price_range[0] <= price <= cls.price_range[1]:
            pass
        elif price > cls.price_range[1]:
            cls.price_range[1] = price
        else:
            cls.price_range[0] = price
        if journey_code > 1470:
            cls.max_code = journey_code
        if holiday_type not in cls.holiday_types:
            cls.holiday_types[holiday_type] = holiday_type
        if accommodation not in cls.accommodations:
            cls.accommodations[accommodation] = accommodation
        if duration not in cls.durations:
            cls.durations.append(duration)
        if hotel not in cls.hotels:
            cls.hotels[hotel] = hotel
        if region not in cls.regions:
            cls.regions[region] = region
        if season not in cls.seasons:
            cls.seasons[season] = season
        if transportation not in cls.transportations:
            cls.transportations[transportation] = transportation
        instance = SourceCase(
            weights, case, journey_code, holiday_type,
            price, number_of_persons, region, transportation,
            duration, season, accommodation, hotel, target_case)
        cls.cases[instance] = instance
        cls.codes[journey_code] = instance
        #  looking for key cases and adding key cases
        if any(cls.key_cases):
            key_case = instance.sim_key_cases()
            if key_case is None:
                cls.key_cases[instance] = {}
            else:
                cls.key_cases[key_case][instance] = instance
        else:
            cls.key_cases[instance] = {}
        return instance

    #  brute force k-NN algorithm for retrieving cases
    @classmethod
    def knn(cls, case):
        similarities = {}
        for instance in cls.cases:
            similarities[instance] = instance.similarity(case)
        return sorted(similarities.items(), key=operator.itemgetter(1), reverse=True)

    #  full footprint-based algorithm for retrieving cases
    @classmethod
    def fprs(cls, case):
        similarities = {}
        key_instances = {}
        key_sims = []
        multiple_key_instances = {}
        for instance in cls.key_cases:
            similarity = instance.similarity(case)
            similarity = float("{0:.2f}".format(round(similarity, 2)))
            key_sims.append(similarity)
            key_instances[similarity] = instance
        #  here is where it says how many key case-groups will be considered
        keys = heapq.nlargest(algorithm['key cases'], key_sims)
        for key in keys:
            multiple_key_instances[key_instances[key]] = key
        for inst in multiple_key_instances:
            for base_inst in cls.key_cases[inst]:
                similarities[base_inst] = base_inst.similarity(case)
        similarities = merge_dicts(multiple_key_instances, similarities)
        return sorted(similarities.items(), key=operator.itemgetter(1), reverse=True)

    def __init__(
            self, weights=None, case=None, journey_code=None, holiday_type=None,
            price=None, number_of_persons=None, region=None, transportation=None,
            duration=None, season=None, accommodation=None, hotel=None, target_case=None):
        super().__init__()
        self.weights = weights
        self.accommodation = Accommodation(accommodation)
        self.case = case
        self.duration = Duration(duration)
        self.holiday_type = HolidayType(holiday_type)
        self.hotel = Hotel(hotel)
        self.journey_code = JourneyCode(journey_code)
        self.number_of_persons = NumberOfPersons(number_of_persons)
        self.price = Price(price, number_of_persons, duration)
        self.region = Region(region)
        self.season = Season(season)
        self.transportation = Transportation(transportation)
        self.target_case = target_case

    #  Help method for finding the key cases,
    #  returning a key case if the similarity is >= 0.75,
    #  otherwise returning None, implying that the new instance will
    #  be a new key case
    def sim_key_cases(self):
        key_case = None
        for instance in self.key_cases:
            similarity = self.similarity(instance, journey_code="skip", hotel="skip")
            sim = float("{0:.2f}".format(round(similarity, 2)))
            #  to change nr of total key cases, edit this number
            #  0.75 was chosen after testing many values in order
            #  to find the one which gave the least number of
            #  considered cases but still gave the correct result
            if sim >= 0.75:
                return instance
        return key_case

    #  Method for solid deletion of a source case instance
    def delete_case(self):
        del self.codes[self.journey_code.number]
        del self.cases[self]
        del self.accommodation
        del self.duration
        del self.holiday_type
        del self.hotel
        del self.journey_code
        del self.number_of_persons
        del self.price
        del self.region
        del self.season
        del self.transportation
        del self

    #  Property resource - get all the case features of the instance as a dictionary
    def get_case_features(self):
        return {
            'Case': self.journey_code.number,
            'Holiday type': self.holiday_type.name,
            'Price': self.price.total,
            'Number of persons': self.number_of_persons.total,
            'Region': self.region.name.title(),
            'Transportation': self.transportation.name,
            'Duration': self.duration.days,
            'Season': self.season.month,
            'Accommodation': self.accommodation.name,
            'Hotel': self.hotel.name
        }

    #  Property resource - get all the case features and the similarity
    #  to the target case as a tuple
    def get_case_tuple(self):
        return (
            "{0:.2f}".format(round(self.similarity(self.target_case)*100, 2)),
            self.journey_code.number,
            self.holiday_type.name,
            self.price.total,
            self.number_of_persons.total,
            self.region.name.title(),
            self.transportation.name,
            self.duration.days,
            self.season.month,
            self.accommodation.name,
            self.hotel.name
        )

    features = property(get_case_features)
    case_tuples = property(get_case_tuple)

    #  The main similarity function for comparing the instance with a given case
    def similarity(
            self,
            case,
            accommodation=None,
            duration=None,
            holiday_type=None,
            hotel=None,
            journey_code=None,
            number_of_persons=None,
            price=None,
            region=None,
            season=None,
            transportation=None
    ):
        #  Below here, all the local similarity metrics are initiated
        sim_int = 0
        total_weight = 0
        # Accommodation
        if (case.accommodation.name is not None) & (accommodation is None):
            weight = self.weights.accommodation
            sim_int += self.accommodation_sim(case) * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        # Duration
        if (case.duration.days is not None) & (duration is None):
            weight = self.weights.duration
            sim_int += self.duration_sim(case) * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        # Holiday type
        if (case.holiday_type.name is not None) & (holiday_type is None):
            weight = self.weights.holiday_type
            sim_int += self.holiday_type_sim(case) * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        # Hotel
        if (case.hotel.name is not None) & (hotel is None):
            weight = self.weights.hotel
            sim_int += self.hotel_sim(case) * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        # Journey code
        if (case.journey_code.number is not None) & (journey_code is None):
            weight = self.weights.journey_code
            sim_int += self.journey_code_sim(case) * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        # Number of persons
        if (case.number_of_persons.total is not None) & (number_of_persons is None):
            weight = self.weights.number_of_persons
            sim_int += self.number_of_persons_sim(case) * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        # Price
        if (case.price.total is not None) & (price is None):
            weight = self.weights.price
            sim_int += self.price_sim(case) * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        # Region
        if (case.region.name is not None) & (region is None):
            weight = self.weights.region
            sim_int += self.region_sim(case) * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        # Season
        if (case.season.name is not None) & (season is None):
            weight = self.weights.season
            sim_int += self.season_sim(case) * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        # Transportation
        if (case.transportation.similarity is not None) & (transportation is None):
            weight = self.weights.transportation
            sim_int += self.transportation_sim(case) * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        return sim_int/total_weight

    #  Here below are all the feature specific similarity functions
    #
    def accommodation_sim(self, case):
        if self.accommodation.index >= case.accommodation.index:
            return 1
        else:
            diff = case.accommodation.index - self.accommodation.index
            return (5 - diff)/5

    def duration_sim(self, case):
        if self.duration.days == case.duration.days:
            return 1
        elif abs(self.duration.days - case.duration.days) <= 4:
            return (5 - abs(self.duration.days - case.duration.days))/5
        else:
            return 0

    def holiday_type_sim(self, case):
        if self.holiday_type.group == case.holiday_type.group:
            return 1
        elif self.holiday_type.group[-3:] == case.holiday_type.group[-3:]:
            if case.holiday_type.group[-3:] == '100':
                return 0.6
            else:
                return 0.5
        else:
            return 0.3

    def hotel_sim(self, case):
        if self.hotel.name == case.hotel.name:
            return 1
        else:
            return 0

    def journey_code_sim(self, case):
        if self.journey_code.number == case.journey_code.number:
            return 1
        else:
            return 0

    def number_of_persons_sim(self, case):
        if self.number_of_persons.total == case.number_of_persons.total:
            return 1
        elif abs(self.number_of_persons.total - case.number_of_persons.total) <= 4:
            return (5 - abs(self.number_of_persons.total - case.number_of_persons.total)) / 5
        else:
            return 0

    def price_sim(self, case):
        if case.price.total < 0:
            return 0
        elif case.price.pppd is None:
            if case.price.per_person is not None:
                if self.price.per_person <= case.price.per_person:
                    return 1
                else:
                    case_diff = self.price.per_person - case.price.per_person
                    price_range = self.price_range[1] / case.number_of_persons.total
                    return (price_range - case_diff) / price_range
            elif case.price.per_day is not None:
                if self.price.per_day <= case.price.per_day:
                    return 1
                else:
                    case_diff = self.price.per_day - case.price.per_day
                    price_range = self.price_range[1] / case.duration.days
                    return (price_range - case_diff) / price_range
            else:
                if self.price.total <= case.price.total:
                    return 1
                else:
                    price_range = (self.price_range[1] - self.price_range[0])
                    return (price_range - (self.price.total - case.price.total)) / price_range
        else:
            if self.price.pppd <= case.price.pppd:
                return 1
            else:
                case_diff = self.price.pppd - case.price.pppd
                price_range = self.price_range[1] / case.number_of_persons.total / case.duration.days
                return (price_range - case_diff) / price_range

    def region_sim(self, case):
        if self.region.name == case.region.name:
            return 1
        elif case.region.coordinates is not None:
            target = (case.region.coordinates['Lat'], case.region.coordinates['Long'])
            source = (self.region.coordinates['Lat'], self.region.coordinates['Long'])
            distance = great_circle(target, source).kilometers
            if distance > self.region.distance:
                return 0
            else:
                lat_distance = great_circle((target[0], 0), (source[0], 0)).kilometers
                latitude_sim = (self.region.distance-lat_distance)/self.region.distance
                distance_sim = (self.region.distance-distance)/self.region.distance
                return (distance_sim + (2 * latitude_sim))/3
        else:
            return 0

    def season_sim(self, case):
        if self.season.month == case.season.month:
            return 1
        elif self.season.name[1] == case.season.name[1]:
            return 0.5
        elif self.season.name[0] == case.season.name[0]:
            return 0.2
        else:
            return 0

    def transportation_sim(self, case):
        return case.transportation.similarity[self.transportation.similarity.index(1.0)]


# This function is used to make instances of all the source cases
def instance_cases(cases, target_case, weights):
    for case in cases:
        case = list(case)
        SourceCase.create(
            weights, case[1], case[0], case[3], int(case[4]),
            int(case[5]), case[6], case[7], int(case[8]),
            case[9], case[10], case[11], target_case)


# This function is used to set a feature for a given case
# based on what is entered in the gui-app
def set_target_case_feature(feature_name, feature_entry, target_case):
    if feature_name == 'Accommodation':
        if feature_entry in SourceCase.accommodations:
            target_case.a = feature_entry
        else:
            del target_case.a
    elif feature_name == 'Duration':
        if feature_entry != '':
            try:
                target_case.d = int(feature_entry)
            except ValueError:
                del target_case.d
        else:
            del target_case.d
    elif feature_name == 'Holiday type':
        if feature_entry in SourceCase.holiday_types:
            target_case.ht = feature_entry
        else:
            del target_case.ht
    elif feature_name == 'Hotel':
        if feature_entry in SourceCase.hotels:
            target_case.h = feature_entry
        else:
            del target_case.h
    elif feature_name == 'Number of persons':
        if feature_entry != '':
            try:
                target_case.nop = int(feature_entry)
            except ValueError:
                del target_case.nop
        else:
            del target_case.nop
    elif feature_name == 'Price':
        if feature_entry != '':
            try:
                target_case.p = int(feature_entry)
            except ValueError:
                del target_case.p
        else:
            del target_case.p
    elif feature_name == 'Region':
        if feature_entry != '':
            target_case.r = feature_entry
        else:
            del target_case.r
    elif feature_name == 'Season':
        if feature_entry in SourceCase.seasons:
            target_case.s = feature_entry
        else:
            del target_case.s
    elif feature_name == 'Transportation':
        if feature_entry in SourceCase.transportations:
            target_case.t = feature_entry
        else:
            del target_case.t
    else:
        pass


if __name__ == '__main__':
    main()
