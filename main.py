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
import time
import heapq


def main():
    target_case = TargetCase()
    instance_cases(retrieve_cases(), target_case)
    # JourneyCase.fprs(target_case)
    Interface(target_case).mainloop()


class MultiColumnListbox:

    def __init__(self, nr_of_results, root):
        self.root = root
        self.tree = None
        self.selected_case = None
        self._setup_widgets()
        self.build_tree(nr_of_results, root)

    def _setup_widgets(self):
        container = ttk.Frame()
        container.pack(fill='both', expand=True, padx=(10, 10), pady=(10, 10))
        # create a treeview with dual scrollbars
        self.tree = ttk.Treeview(columns=JourneyCase.list, show="headings")
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

    def build_tree(self, nr_of_results, root):
        for col in JourneyCase.list:
            self.tree.heading(col, text=col, command=lambda c=col: sortby(self.tree, c, 0))
            # adjust the column's width to the header string
            if col == 'Hotel name':
                self.tree.column(col, width=tkFont.Font().measure(col) * 3)
            else:
                self.tree.column(col, width=tkFont.Font().measure(col))
        start_time = time.time()
        results = JourneyCase.fprs(root.target_case) if not algorithm['fast'] else JourneyCase.knn(root.target_case)
        print("Execution time FPRS: " + str(time.time() - start_time))
        print(results[0][1], results[0][0].journey_code.number)
        start_time = time.time()
        results = JourneyCase.fprs(root.target_case) if algorithm['fast'] else JourneyCase.knn(root.target_case)
        print("Execution time k-NN: " + str(time.time() - start_time))
        print(results[0][1], results[0][0].journey_code.number)
        if len(results) < nr_of_results:
            nr_of_results = len(results)
        for item in results[0:nr_of_results]:
            self.tree.insert('', 'end', values=item[0].case_tuples)

    def selection(self, event):
        self.root.case_buttons_state("normal")
        if event.type == '5':  # mouse click
            item_id = self.tree.identify_row(event.y)
            self.selected_case = JourneyCase.codes[self.tree.item(item_id)["values"][1]]
        elif event.type == '2':
            if (event.keycode == 8320768) & (self.tree.prev(self.tree.focus()) != ''):  # up
                item_id = self.tree.prev(self.tree.focus())
                self.selected_case = JourneyCase.codes[self.tree.item(item_id)["values"][1]]
            elif (event.keycode == 8255233) & (self.tree.next(self.tree.focus()) != ''):  # down
                item_id = self.tree.next(self.tree.focus())
                self.selected_case = JourneyCase.codes[self.tree.item(item_id)["values"][1]]
            else:
                pass
        else:
            pass

    def get_selected_case(self):
        return self.selected_case

    case = property(get_selected_case)


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


class Menu:

    def __init__(self, master):
        self.root = tk.Menu(master)
        # 'File'
        self.file_menu = tk.Menu(self.root, tearoff=0)
        self.file_menu.add_command(label="About")
        self.file_menu.add_command(label="Help")
        self.file_menu.add_separator()
        self.file_menu.add_command(label="Quit program", command=master.quit)
        self.root.add_cascade(label="File", menu=self.file_menu)
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
        # self.sim_menu.add_command(label=, command=master.set_algorithm)
        self.sim_menu.add_command(label="Edit weights", command=master.weights_window)
        self.root.add_cascade(label="Similarities", menu=self.sim_menu)
        # Configure the menu
        master.config(menu=self.root)

    def callback(self):
        pass


class Interface(tk.Tk):
    field_row = 0
    field_column = 1
    entries = {}
    nr_of_results = 100
    edit_entries = {}
    weight_entries = {}

    def __init__(self, target_case):
        tk.Tk.__init__(self)
        self.target_case = target_case
        self.title('CBR Travel Case')
        self.window = None
        self.message_box = None
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
        self.list = MultiColumnListbox(self.nr_of_results, self)
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
        self.status_text.set("Using FPRS" if algorithm['fast'] else "Using k-NN")
        self.status = ttk.Label(justify="left", padding=(10, 2, 10, 2), textvariable=self.status_text, relief=tk.RAISED)
        self.status.pack(side=tk.BOTTOM, fill='x')

    def get_best_matches(self):
        self.list.tree.delete(*self.list.tree.get_children())
        self.case_buttons_state("disabled")
        for entry in self.entries:
            set_target_case_feature(entry, self.entries[entry].input, self.target_case)
        self.list.build_tree(self.nr_of_results, self)
        self.status_text.set("Using FPRS" if algorithm['fast'] else "Using k-NN")

    def case_buttons_state(self, state):
        self.dc_button.config(state=state)
        self.ec_button.config(state=state)
        self.menu.cb_menu.entryconfig("Edit selected case", state=state)
        self.menu.cb_menu.entryconfig("Delete selected case", state=state)

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
        new_case[1] = 'Journey' + str(JourneyCase.max_code)
        new_case[0] = JourneyCase.max_code
        new_case[2] = ''
        cases_to_create = [new_case]
        instance_cases(cases_to_create, self.target_case)
        self.list.build_tree(self.nr_of_results, self)
        self.edit_entries = {}
        self.window.destroy()

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

    def edit_case(self, case):
        self.list.tree.delete(*self.list.tree.get_children())
        self.case_buttons_state("disabled")
        for entry in self.edit_entries:
            set_target_case_feature(entry, self.edit_entries[entry].input, case)
        self.list.build_tree(self.nr_of_results, self)
        self.edit_entries = {}
        self.window.destroy()

    def delete_case_message(self):
        answer = tkinter.messagebox.askquestion(
            'Delete case',
            'Are you sure you want to delete case ' + str(self.list.case.journey_code.number) + '?'
        )
        if answer == 'yes':
            case = self.list.case
            case.delete_case()
            self.get_best_matches()

    def set_algorithm(self):
        text = 'regular k-NN' if algorithm['fast'] else 'FPRS'
        answer = tkinter.messagebox.askquestion(
            'Set algorithm',
            'Are you sure you want to switch to ' + text + '?'
        )
        if answer == 'yes':
            algorithm['fast'] = not algorithm['fast']
            self.menu.sim_name = 'Switch to k-NN' if algorithm['fast'] else 'Switch to FPRS'
            self.menu.sim_menu.entryconfigure(0, label=self.menu.sim_name)
            self.get_best_matches()

    def weights_window(self):
        self.window = tk.Toplevel(self)
        self.weight_entries = {}
        self.window.field_frame = tk.Frame(self.window)
        self.window.field_frame.pack(side=tk.TOP, pady=(10, 0))
        for weight in weights_global:
            self.weight_entries[weight] = Field.create(
                self.window.field_frame,
                weight,
                self.field_row,
                self.field_column,
                weights_global[weight]
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

    def edit_weights(self):
        for weight in self.weight_entries:
            entry = self.weight_entries[weight]
            if self.weight_entries[weight] != '':
                weights_global[weight] = int(entry.input)
        self.get_best_matches()
        self.window.destroy()
        self.weight_entries = {}


class TargetCase:

    def __init__(
            self, case=None, journey_code=None, holiday_type=None,
            price=None, number_of_persons=None, region=None, transportation=None,
            duration=None, season=None, accommodation=None, hotel=None):
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


class JourneyCase(TargetCase):
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
        'Price [NZD]',
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
            cls, case, journey_code, holiday_type,
            price, number_of_persons, region, transportation,
            duration, season, accommodation, hotel, target_case):
        instance = JourneyCase(
            case, journey_code, holiday_type,
            price, number_of_persons, region, transportation,
            duration, season, accommodation, hotel, target_case)
        cls.cases[instance] = instance
        cls.codes[journey_code] = instance
        if journey_code > 1470:
            cls.max_code = journey_code
        if holiday_type not in cls.holiday_types:
            cls.holiday_types[holiday_type] = holiday_type
        if accommodation not in cls.accommodations:
            cls.accommodations[accommodation] = accommodation
        if instance.duration.days not in cls.durations:
            cls.durations.append(instance.duration.days)
        if hotel not in cls.hotels:
            cls.hotels[hotel] = hotel
        if region not in cls.regions:
            cls.regions[region] = region
        if season not in cls.seasons:
            cls.seasons[season] = season
        if transportation not in cls.transportations:
            cls.transportations[transportation] = transportation
        if any(cls.key_cases):
            key_case = instance.sim_key_cases()
            if key_case is None:
                cls.key_cases[instance] = {}
            else:
                cls.key_cases[key_case][instance] = instance
        else:
            cls.key_cases[instance] = {}
        return instance

    @classmethod
    def knn(cls, case):
        nr = 0
        similarities = {}
        for instance in cls.cases:
            similarities[instance] = instance.similarity(case)
            nr += 1
        print('Cases considered with k-NN: ' + str(nr))
        return sorted(similarities.items(), key=operator.itemgetter(1), reverse=True)

    @classmethod
    def fprs(cls, case):
        nr = 0
        similarities = {}
        key_instances = {}
        key_sims = []
        multiple_key_instances = {}
        for instance in cls.key_cases:
            similarity = instance.similarity(case)
            nr += 1
            similarity = float("{0:.2f}".format(round(similarity, 2)))
            key_sims.append(similarity)
            key_instances[similarity] = instance
        keys = heapq.nlargest(algorithm['key cases'], key_sims)
        for key in keys:
            multiple_key_instances[key_instances[key]] = key
        for inst in multiple_key_instances:
            for base_inst in cls.key_cases[inst]:
                similarities[base_inst] = base_inst.similarity(case)
                nr += 1
        similarities = merge_dicts(multiple_key_instances, similarities)
        print('Cases considered with fprs: ' + str(nr))
        return sorted(similarities.items(), key=operator.itemgetter(1), reverse=True)

    def __init__(
            self, case=None, journey_code=None, holiday_type=None,
            price=None, number_of_persons=None, region=None, transportation=None,
            duration=None, season=None, accommodation=None, hotel=None, target_case=TargetCase()):
        super().__init__()
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
        self.target_case = target_case
        self.similarity(self.target_case)

    def sim_key_cases(self):
        key_case = None
        for instance in self.key_cases:
            similarity = self.similarity(instance, journey_code="skip", hotel="skip")
            sim = float("{0:.2f}".format(round(similarity, 2)))
            if sim >= 0.75:
                return instance
        return key_case

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
        sim_int = 0
        total_weight = 0
        # Accommodation
        if (case.accommodation.name is not None) & (accommodation is None):
            weight = self.accommodation.weight
            sim_int += self.accommodation_sim(case) * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        # Duration
        if (case.duration.days is not None) & (duration is None):
            weight = self.duration.weight
            sim_int += self.duration_sim(case) * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        # Holiday type
        if (case.holiday_type.name is not None) & (holiday_type is None):
            weight = self.holiday_type.weight
            sim_int += self.holiday_type_sim(case) * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        # Hotel
        if (case.hotel.name is not None) & (hotel is None):
            weight = self.hotel.weight
            sim_int += self.hotel_sim(case) * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        # Journey code
        if (case.journey_code.number is not None) & (journey_code is None):
            weight = self.journey_code.weight
            sim_int += self.journey_code_sim(case) * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        # Number of persons
        if (case.number_of_persons.total is not None) & (number_of_persons is None):
            weight = self.number_of_persons.weight
            sim_int += self.number_of_persons_sim(case) * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        # Price
        if (case.price.total is not None) & (price is None):
            weight = self.price.weight
            sim_int += self.price_sim(case) * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        # Region
        if (case.region.name is not None) & (region is None):
            weight = self.region.weight
            sim_int += self.region_sim(case) * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        # Season
        if (case.season.name is not None) & (season is None):
            weight = self.season.weight
            sim_int += self.season_sim(case) * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        # Transportation
        if (case.transportation.similarity is not None) & (transportation is None):
            weight = self.transportation.weight
            sim_int += self.transportation_sim(case) * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        return sim_int/total_weight

    def accommodation_sim(self, case):
        if self.accommodation.index >= case.accommodation.index:
            return 1
        else:
            return self.accommodation.index/case.accommodation.index

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
        elif abs(self.number_of_persons.total - case.number_of_persons.total) < 2:
            return 0.5
        else:
            return 0

    def price_sim(self, case):
        if (self.price.total <= case.price.total) | (case.price.total > self.price_range[1]):
            return 1
        elif case.price.total < self.price_range[0]:
            return 0
        else:
            return 1 - ((self.price.total - case.price.total) / (self.price_range[1] - self.price_range[0]))

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


def instance_cases(cases, target_case):
    for case in cases:
        case = list(case)
        JourneyCase.create(
            case[1], case[0], case[3], int(case[4]),
            int(case[5]), case[6], case[7], int(case[8]),
            case[9], case[10], case[11], target_case)


def set_target_case_feature(feature_name, feature_entry, target_case):
    if feature_name == 'Accommodation':
        if feature_entry in JourneyCase.accommodations:
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
        if feature_entry in JourneyCase.holiday_types:
            target_case.ht = feature_entry
        else:
            del target_case.ht
    elif feature_name == 'Hotel':
        if feature_entry in JourneyCase.hotels:
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
        if feature_entry in JourneyCase.seasons:
            target_case.s = feature_entry
        else:
            del target_case.s
    elif feature_name == 'Transportation':
        if feature_entry in JourneyCase.transportations:
            target_case.t = feature_entry
        else:
            del target_case.t
    else:
        pass


if __name__ == '__main__':
    main()
