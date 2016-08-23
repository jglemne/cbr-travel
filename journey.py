#!/usr/local/bin/python3.5

# import modules used here -- sys is a very standard one
import sys
# import platform
import openpyxl
import operator
# import time
from geopy.geocoders import Nominatim
from geopy.distance import great_circle
import psycopg2
import tkinter as tk
import tkinter.font as tkFont
import tkinter.ttk as ttk
# import magic
# import numpy as np
import re
# from time import sleep

# Gather our code in a main() function


def main():
    target_case = TargetCase()
    instance_cases(retrieve_cases(), target_case)
    Interface(target_case).mainloop()
    # root = tk.Tk()
    # root.title("Multicolumn Treeview/Listbox")
    # listbox = MultiColumnListbox()
    # root.mainloop()


class MultiColumnListbox():
    """use a ttk.TreeView as a multicolumn ListBox"""

    def __init__(self):
        self.tree = None
        self._setup_widgets()
        self._build_tree()

    def _setup_widgets(self):
        s = "\click on header to sort by that column to change width of column drag boundary"
        msg = ttk.Label(wraplength="4i", justify="left", anchor="n",
                        padding=(10, 2, 10, 6), text=s)
        msg.pack(fill='x')
        container = ttk.Frame()
        container.pack(fill='both', expand=True)
        # container.grid(column=)
        # create a treeview with dual scrollbars
        self.tree = ttk.Treeview(columns=car_header, show="headings")
        vsb = ttk.Scrollbar(orient="vertical",
                            command=self.tree.yview)
        hsb = ttk.Scrollbar(orient="horizontal",
                            command=self.tree.xview)
        self.tree.configure(yscrollcommand=vsb.set,
                            xscrollcommand=hsb.set)
        self.tree.grid(column=0, row=0, sticky='nsew', in_=container)
        vsb.grid(column=1, row=0, sticky='ns', in_=container)
        hsb.grid(column=0, row=1, sticky='ew', in_=container)
        container.grid_columnconfigure(0, weight=1)
        container.grid_rowconfigure(0, weight=1)

    def _build_tree(self):
        for col in car_header:
            self.tree.heading(col, text=col.title(),
                              command=lambda c=col: sortby(self.tree, c, 0))
            # adjust the column's width to the header string
            self.tree.column(col,
                             width=tkFont.Font().measure(col.title()))

        for item in car_list:
            self.tree.insert('', 'end', values=item)
            # adjust column's width if necessary to fit each value
            for ix, val in enumerate(item):
                col_w = tkFont.Font().measure(val)
                if self.tree.column(car_header[ix], width=None) < col_w:
                    self.tree.column(car_header[ix], width=col_w)


class Field:
    fields = {}

    @classmethod
    def create(cls, master, label_text, row, col):
        instance = Field(master, label_text, row, col)
        cls.fields[label_text] = instance
        return instance

    def __init__(self, master, label_text, row, col):
        self.label = tk.Label(master, text=label_text)
        self.entry = tk.Entry(master)
        self.row = row
        self.col = col

    def make_grid(self):
        self.label.grid(row=self.row, sticky=tk.E)
        self.entry.grid(row=self.row, column=self.col)

    def get_input(self):
        return self.entry.get()


class DropDown:
    drop_downs = {}

    @classmethod
    def create(cls, master, label_text, row, col):
        instance = DropDown(master, label_text, row, col)
        cls.drop_downs[label_text] = instance
        return instance

    def __init__(self, master, label_text, row, col):
        self.var = tk.StringVar(master)
        self.label = tk.Label(master, text=label_text)
        self.entry = tk.OptionMenu(master, self.var, *drop_downs_global[label_text])
        self.row = row
        self.col = col

    def make_grid(self):
        self.label.grid(row=self.row, sticky=tk.E)
        self.entry.grid(row=self.row, column=self.col, sticky=tk.EW)

    def get_input(self):
        return self.var.get()


class ListCases:

    @classmethod
    def create(cls, master, row, col):
        instance = ListCases(master, row, col)
        return instance

    def __init__(self, master, row, col):
        self.var = tk.Scrollbar(master)
        self.var.grid(row=row, column=col+2, sticky=tk.NE + tk.SE)
        self.list = tk.Listbox(master, yscrollcommand=self.var.set)
        self.list_cases(20)
        self.list.grid(row=row, column=col-1, sticky=tk.EW, columnspan=3)
        self.var.config(command=self.list.yview)

    def list_cases(self, number):
        self.list.delete(0, tk.END)
        for case in JourneyCase.similarities()[0:number]:
            feature_string = ''
            for feature in case[0].features:
                feature_string += feature + ': ' + str(case[0].features[feature]) + ', '
            self.list.insert(tk.END, feature_string + 'Similarity: ' + str(case[1]))


class Interface(tk.Tk):
    field_row = 0
    field_column = 1
    entries = {}

    def __init__(self, target_case):
        tk.Tk.__init__(self)
        self.title('CBR Travel Case')
        for field in fields_global:
            self.entries[field] = Field.create(self, field, self.field_row, self.field_column)
            self.entries[field].make_grid()
            self.field_row += 1
        for drop_down in drop_downs_global:
            self.entries[drop_down] = DropDown.create(self, drop_down, self.field_row, self.field_column)
            self.entries[drop_down].make_grid()
            self.field_row += 1
        self.case_list = ListCases.create(self, self.field_row, self.field_column)
        # self.case_list = MultiColumnListbox()
        self.button = tk.Button(self, text="Get best matches", command=self.on_button)
        self.button.grid(columnspan=2)
        self.target_case = target_case

    def on_button(self):
        for entry in self.entries:
            set_target_case_feature(entry, self.entries[entry].get_input(), self.target_case)
        self.case_list.list_cases(20)


class Accommodation:
    indices = {'HolidayFlat': 1, 'OneStar': 2, 'TwoStars': 3, 'ThreeStars': 4, 'FourStars': 5, 'FiveStars': 6}
    weight = 3

    def __init__(self, accommodation=None):
        self.name = accommodation
        self.index = self.indices.get(accommodation)


class Duration:
    weight = 1

    def __init__(self, duration=None):
        self.days = duration


class HolidayType:
    groups = {
        'Arbitrary': '0000000', 'Active': '0001001', 'City': '0010010', 'Education': '0011011',
        'Recreation': '0100100', 'Shopping': '0101010', 'Language': '0110011', 'Bathing': '0111100',
        'Wandering': '1000100', 'Adventure': '1001001', 'Diving': '1010001', 'Skiing': '1011001',
        'Surfing': '1100001'
    }
    weight = 10

    def __init__(self, holiday_type=None):
        self.name = holiday_type
        self.group = self.groups.get(holiday_type)


class Hotel:
    weight = 20

    def __init__(self, hotel=None):
        self.name = hotel


class JourneyCode:
    weight = 200

    def __init__(self, journey_code=None):
        self.number = journey_code


class NumberOfPersons:
    weight = 2

    def __init__(self, number_of_persons=None):
        self.total = number_of_persons


class Price:
    weight = 7

    def __init__(self, price=None, number_of_persons=None):
        self.total = price
        if number_of_persons is not None:
            self.per_person = price/number_of_persons
        else:
            self.per_person = None


class Region:
    weight = 2
    distance = 2000
    regions = {}

    def __init__(self, region=None):
        if region is not None:
            region = region.lower()
        self.name = region
        if region is not None:
            if region not in self.regions:
                self.new_region(region)
            self.coordinates = self.regions[region]
        else:
            self.coordinates = None

    @classmethod
    def list_regions(cls):
        return {}.fromkeys(cls.regions).keys()

    def new_region(self, region):
        self.regions[region] = {'Long': '', 'Lat': ''}
        conn = psycopg2.connect("dbname='travel'")
        cur = conn.cursor()
        cur.execute("select latitude, longitude from regions where region_name = %s", (region,))
        result = cur.fetchall()
        if len(result) == 0:
            geolocator = Nominatim()  # TODO: must learn how to use timeout() & catch error
            location = geolocator.geocode(region)
            if location.longitude is not None:
                new_longitude = location.longitude
                new_latitude = location.latitude
                self.regions[region]['Long'] = new_longitude
                self.regions[region]['Lat'] = new_latitude
                cur.execute("INSERT INTO regions (region_name,latitude,longitude) VALUES (%s,%s,%s)",
                            (region, new_latitude, new_longitude))
                conn.commit()
        else:
            self.regions[region]['Lat'] = result[0][0]
            self.regions[region]['Long'] = result[0][1]


class Season:
    weight = 4
    seasons = {
        'January': ['Winter', 'Winter'],
        'February': ['Spring', 'Winter'],
        'March': ['Winter', 'Spring'],
        'April': ['Spring', 'Spring'],
        'May': ['Summer', 'Spring'],
        'June': ['Spring', 'Summer'],
        'July': ['Summer', 'Summer'],
        'August': ['Autumn', 'Summer'],
        'September': ['Summer', 'Autumn'],
        'October': ['Autumn', 'Autumn'],
        'November': ['Winter', 'Autumn'],
        'December': ['Autumn', 'Winter']
    }

    def __init__(self, season=None):
        self.month = season
        if season is not None:
            self.name = self.seasons[season]
        else:
            self.name = None


class Transportation:
    weight = 4
    similarities = {
        'Car': [1, 0.5, 0.0, 0.8],
        'Coach': [0.5, 1.0, 0.0, 0.7],
        'Plane': [0.0, 0.0, 1.0, 0.0],
        'Train': [0.3, 0.7, 0.0, 1.0]
    }

    def __init__(self, transportation=None):
        self.name = transportation
        if transportation is not None:
            self.similarity = self.similarities[transportation]
        else:
            self.similarity = None


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


class JourneyCase:
    cases = {}
    max_code = 0
    holiday_types = {}
    holiday_list = []
    prices = {}
    prices_dict = {}
    persons_per_case = []
    price_range = [279, 7161]
    durations = []
    accommodations = {}
    hotels = {}
    regions = {}
    seasons = {}
    transportations = {}

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
        if cls.max_code < int(instance.journey_code.number):
            cls.max_code = int(instance.journey_code.number)
        if holiday_type not in cls.holiday_types:
            cls.holiday_types[holiday_type] = holiday_type
        cls.prices[instance] = instance.price.total
        cls.persons_per_case.append(instance.number_of_persons.total)
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
        return instance

    @classmethod
    def similarities(cls):
        similarities = {}
        for instance in cls.cases:
            similarities[instance] = instance.similarity()
        return sorted(similarities.items(), key=operator.itemgetter(1), reverse=True)

    def __init__(
            self, case=None, journey_code=None, holiday_type=None,
            price=None, number_of_persons=None, region=None, transportation=None,
            duration=None, season=None, accommodation=None, hotel=None, target_case=TargetCase()):
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
        self.similarity()

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

    features = property(get_case_features)

    def similarity(self):
        sim_int = 0
        total_weight = 0
        # Accommodation
        if self.target_case.accommodation.name is not None:
            weight = self.accommodation.weight
            sim_int += self.accommodation_sim() * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        # Duration
        if self.target_case.duration.days is not None:
            weight = self.duration.weight
            sim_int += self.duration_sim() * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        # Holiday type
        if self.target_case.holiday_type.name is not None:
            weight = self.holiday_type.weight
            sim_int += self.holiday_type_sim() * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        # Hotel
        if self.target_case.hotel.name is not None:
            weight = self.hotel.weight
            sim_int += self.hotel_sim() * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        # Journey code
        if self.target_case.journey_code.number is not None:
            weight = self.journey_code.weight
            sim_int += self.journey_code_sim() * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        # Number of persons
        if self.target_case.number_of_persons.total is not None:
            weight = self.number_of_persons.weight
            sim_int += self.number_of_persons_sim() * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        # Price
        if self.target_case.price.total is not None:
            weight = self.price.weight
            sim_int += self.price_sim() * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        # Region
        if self.target_case.region.name is not None:
            weight = self.region.weight
            sim_int += self.region_sim() * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        # Season
        if self.target_case.season.name is not None:
            weight = self.season.weight
            sim_int += self.season_sim() * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        # Transportation
        if self.target_case.transportation.similarity is not None:
            weight = self.transportation.weight
            sim_int += self.transportation_sim() * weight
            total_weight += weight
        else:
            sim_int += 1
            total_weight += 1
        return sim_int/total_weight

    def accommodation_sim(self):
        if self.accommodation.index >= self.target_case.accommodation.index:
            return 1
        else:
            return self.accommodation.index/self.target_case.accommodation.index

    def duration_sim(self):
        if self.duration.days == self.target_case.duration.days:
            return 1
        elif abs(self.duration.days - self.target_case.duration.days) <= 4:
            return (5 - abs(self.duration.days - self.target_case.duration.days))/5
        else:
            return 0

    def holiday_type_sim(self):
        if self.holiday_type.group == self.target_case.holiday_type.group:
            return 1
        elif self.holiday_type.group[-3:] == self.target_case.holiday_type.group[-3:]:
            if self.target_case.holiday_type.group[-3:] == '100':
                return 0.6
            else:
                return 0.5
        else:
            return 0.3

    def hotel_sim(self):
        if self.hotel.name == self.target_case.hotel.name:
            return 1
        else:
            return 0

    def journey_code_sim(self):
        if self.journey_code.number == self.target_case.journey_code.number:
            return 1
        else:
            return 0

    def number_of_persons_sim(self):
        if self.number_of_persons.total == self.target_case.number_of_persons.total:
            return 1
        elif abs(self.number_of_persons.total - self.target_case.number_of_persons.total) < 2:
            return 0.5
        else:
            return 0

    def price_sim(self):
        if self.price.total <= self.target_case.price.total:
            return 1
        else:
            return (self.price_range[1] - self.price.total) / (self.price_range[1] - self.price_range[0])

    def region_sim(self):
        if self.region.name == self.target_case.region.name:
            return 1
        elif self.target_case.region.coordinates is not None:
            target = (self.target_case.region.coordinates['Lat'], self.target_case.region.coordinates['Long'])
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

    def season_sim(self):
        if self.season.month == self.target_case.season.month:
            return 1
        elif self.season.name[1] == self.target_case.season.name[1]:
            return 0.5
        elif self.season.name[0] == self.target_case.season.name[0]:
            return 0.2
        else:
            return 0

    def transportation_sim(self):
        return self.target_case.transportation.similarity[self.transportation.similarity.index(1.0)]


def get_cases_ascii(file_name):
    f = open(file_name, 'r')
    cases = {}
    for line in f.readlines():
        line = line.strip()
        columns = line.split()
        line_length = len(columns)
        if line_length >= 1:
            name = columns[0]
            if name == 'defcase':
                cases[columns[1]] = []
                defcase = columns[1]
            elif name == 'case':
                cases[defcase].append(columns[1])
            elif name == 'JourneyCode:':
                cases[defcase].append(columns[1])
            elif name == 'HolidayType:':
                cases[defcase].append(columns[1].replace(',', ''))
            elif name == 'Price:':
                cases[defcase].append(columns[1])
            elif name == 'NumberOfPersons:':
                cases[defcase].append(columns[1])
            elif name == 'Region:':
                cases[defcase].append(columns[1].replace(',', ''))
            elif name == 'Transportation:':
                cases[defcase].append(columns[1].replace(',', ''))
            elif name == 'Duration:':
                cases[defcase].append(columns[1])
            elif name == 'Season:':
                cases[defcase].append(columns[1].replace(',', ''))
            elif name == 'Accommodation:':
                cases[defcase].append(columns[1].replace(',', ''))
            elif name == 'Hotel:':
                number_of_columns = 1
                hotel_name = ''
                while number_of_columns < line_length:
                    hotel_name += columns[number_of_columns] + ' '
                    number_of_columns += 1
                cases[defcase].append(hotel_name.replace('"', '')[:-1])
            else:
                pass
    f.close()
    return cases


def retrieve_cases():
    conn = psycopg2.connect("dbname='travel'")
    cur = conn.cursor()
    cur.execute("SELECT * from cases")
    return cur.fetchall()


def instance_cases(cases, target_case):
    for case in cases:
        case = list(case)
        JourneyCase.create(
            case[1], case[0], case[3], int(case[4]),
            int(case[5]), case[6], case[7], int(case[8]),
            case[9], case[10], case[11], target_case)


def load_cases_excel(file_name, target_case):
    wb = openpyxl.load_workbook(file_name)
    sheet_names = wb.get_sheet_names()
    sheet_name = sheet_names[0]
    sheet = wb.get_sheet_by_name(sheet_name)
    case_column = 3
    case_row = 1
    is_case = True
    while is_case:
        case = [None] * 11
        header_cell = sheet.cell(row=case_row, column=case_column-2).value
        if header_cell is None or header_cell != 'defcase':
            is_case = False
        else:
            for next_cell in range(2, 13):
                case[next_cell-2] = sheet.cell(row=case_row + next_cell, column=3).value
            JourneyCase.create(
                case[0], case[1], case[2].replace(',', ''), case[3],
                case[4], case[5].replace(',', ''), case[6].replace(',', ''), case[7],
                case[8].replace(',', ''), case[9].replace(',', ''), case[10], target_case)
        case_row += 16


def format_case_list_to_database(case):
    new_case = ({
        "case_name": case[0],
        "journey_code": case[1],
        "holiday_type": case[2],
        "price": case[3],
        "number_of_persons": case[4],
        "region": lower_case_string(case[5]),
        "transportation": case[6],
        "duration": case[7],
        "season": case[8],
        "accommodation": case[9],
        "hotel": case[10],
    })
    return new_case


def format_case_instance_to_database(new_case):
    case = ({
        "id": new_case.journey_code.number,
        "case_name": new_case.case,
        "journey_code": new_case.journey_code.number,
        "holiday_type": new_case.holiday_type.name,
        "price": new_case.price.total,
        "number_of_persons": new_case.number_of_persons.total,
        "region": new_case.region.name,
        "transportation": new_case.transportation.name,
        "duration": new_case.duration.days,
        "season": new_case.season.month,
        "accommodation": new_case.accommodation.name,
        "hotel": new_case.hotel.name
    })
    return case


def load_cases_to_database(cases):
    counter = 1
    list_cases = []
    while counter <= len(cases):
        string_counter = str(counter)
        case = format_case_list_to_database(cases[string_counter])
        list_cases.append(case)
        counter += 1
    tuple_cases = tuple(list_cases)
    commit_cases_to_database(tuple_cases)


def add_cases_to_database(cases):
    counter = 0
    list_cases = []
    while counter <= len(cases)-1:
        case = format_case_instance_to_database(cases[counter])
        list_cases.append(case)
        counter += 1
    tuple_cases = tuple(list_cases)
    commit_cases_to_database(tuple_cases)


def commit_cases_to_database(case_tuple):
    conn = psycopg2.connect("dbname='travel'")
    cur = conn.cursor()
    cur.executemany(
        "INSERT INTO cases("
        "case_name,"
        "journey_code,"
        "holiday_type,"
        "price,"
        "number_of_persons,"
        "region,"
        "transportation,"
        "duration,"
        "season,"
        "accommodation,"
        "hotel) "
        "VALUES ("
        "%(case_name)s, "
        "%(journey_code)s, "
        "%(holiday_type)s, "
        "%(price)s, "
        "%(number_of_persons)s, "
        "%(region)s, "
        "%(transportation)s, "
        "%(duration)s, "
        "%(season)s, "
        "%(accommodation)s, "
        "%(hotel)s)", case_tuple)
    conn.commit()


def lower_case_string(st):
    my_list = re.findall('[A-Z][^A-Z]*', st)
    region = ''
    for x in my_list:
        word = x.lower()
        region += word.replace(' ', '') + ' '
    return region[:-1]


def load_regions_to_database(regions):
    regions_list = []
    for key in regions:
        region_dict = {
            'region_name': lower_case_string(key),
            'latitude': regions[key]['Lat'],
            'longitude': regions[key]['Long']
        }
        regions_list.append(region_dict)
    commit_regions_to_database(tuple(regions_list))


def commit_regions_to_database(region_tuple):
    conn = psycopg2.connect("dbname='travel'")
    cur = conn.cursor()
    cur.executemany(
        "INSERT INTO regions("
        "region_name,"
        "latitude,"
        "longitude) "
        "VALUES ("
        "%(region_name)s, "
        "%(latitude)s, "
        "%(longitude)s)", region_tuple)
    conn.commit()


def count_cases(sheet):
    is_case = True
    cell_letter = 'A'
    cell_number = '1'
    number_of_cases = 0
    while is_case:
        if sheet[cell_letter + cell_number].value is None or sheet[cell_letter + cell_number].value != 'defcase':
            is_case = False
        else:
            number_of_cases += 1
            cell_int = int(cell_number)
            cell_int += 16
            cell_number = str(cell_int)
    return number_of_cases


def get_cases_price_interval(lowest_price, highest_price):
    indices = []
    my_dict = JourneyCase.prices
    for price in range(lowest_price, highest_price):
        empty_dict = False
        while not empty_dict:
            if price in my_dict.values():
                case = list(my_dict.keys())[list(my_dict.values()).index(price)]
                indices.append(case)
                my_dict = remove_key(my_dict, case)
            else:
                empty_dict = True
    return indices


def remove_key(d, key):
    r = dict(d)
    del r[key]
    return r


def best_matches(number_of_matches):
    print(JourneyCase.similarities()[:number_of_matches])


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
    elif feature_name == 'Hotel name':
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


def hamming_distance(s1, s2):
    if len(s1) != len(s2):
        raise ValueError("Undefined for sequences of unequal length")
    return sum(el1 != el2 for el1, el2 in zip(s1, s2))


def sortby(tree, col, descending):
    """sort tree contents when a column header is clicked on"""
    # grab values to sort
    data = [(tree.set(child, col), child) \
        for child in tree.get_children('')]
    # if the data to be sorted is numeric change to float
    #data =  change_numeric(data)
    # now sort the data in place
    data.sort(reverse=descending)
    for ix, item in enumerate(data):
        tree.move(item[1], '', ix)
    # switch the heading so it will sort in the opposite direction
    tree.heading(col, command=lambda col=col: sortby(tree, col,
        int(not descending)))


# the test data ...

car_header = ['car', 'repair']
car_list = [
('Hyundai', 'brakes') ,
('Honda', 'light') ,
('Lexus', 'battery') ,
('Benz', 'wiper') ,
('Ford', 'tire') ,
('Chevy', 'air') ,
('Chrysler', 'piston') ,
('Toyota', 'brake pedal') ,
('BMW', 'seat')
]

regions_global = {
    'AdriaticSea': {'Lat': 43.7021514, 'Long': 14.6679465},
    'Algarve': {'Lat': 37.2454248, 'Long': -8.15092517307923},
    'Allgaeu': {'Lat': 47.7852787, 'Long': 11.6243293},
    'Alps': {'Lat': 46.887619, 'Long': 9.6569996},
    'Atlantic': {'Lat': 46.513516, 'Long': -1.7358398},
    'Attica': {'Lat': 40.294204, 'Long': -87.248899},
    'Balaton': {'Lat': 46.830268, 'Long': 17.734044},
    'BalticSea': {'Lat': 58.487952, 'Long': 19.863281},
    'Bavaria': {'Lat': 48.790447, 'Long': 11.497889},
    'Belgium': {'Lat': 50.503887, 'Long': 4.469936},
    'BlackForest': {'Lat': 47.841544, 'Long': 7.960641},
    'Bornholm': {'Lat': 55.160428, 'Long': 14.866884},
    'Brittany': {'Lat': 48.202047, 'Long': -2.932644},
    'Bulgaria': {'Lat': 42.733883, 'Long': 25.48583},
    'Cairo': {'Lat': 30.04442, 'Long': 31.235712},
    'Carinthia': {'Lat': 46.722203, 'Long': 14.180588},
    'Chalkidiki': {'Lat': 40.3695, 'Long': 23.287085},
    'Corfu': {'Lat': 39.624262, 'Long': 19.921678},
    'Corsica': {'Lat': 42.039604, 'Long': 9.012893},
    'CostaBlanca': {'Lat': 38.504384, 'Long': -0.264345},
    'CostaBrava': {'Lat': 42.275527, 'Long': 3.017571},
    'CotedAzur': {'Lat': 43.120359, 'Long': 6.920913},
    'Cyprus': {'Lat': 35.126413, 'Long': 33.429859},
    'Crete': {'Lat': 35.240117, 'Long': 24.809269},
    'Czechia': {'Lat': 49.817492, 'Long': 15.472962},
    'Denmark': {'Lat': 56.26392, 'Long': 9.501785},
    'Dolomites': {'Lat': 46.410212, 'Long': 11.844035},
    'Egypt': {'Lat': 26.820553, 'Long': 30.802498},
    'England': {'Lat': 52.355518, 'Long': -1.17432},
    'ErzGebirge': {'Lat': 50.58, 'Long': 13},
    'Fano': {'Lat': 43.839816, 'Long': 13.01942},
    'France': {'Lat': 46.227638, 'Long': 2.213749},
    'Fuerteventura': {'Lat': 28.358744, 'Long': -14.053676},
    'GiantMountains': {'Lat': 50.767222, 'Long': 15.622222},
    'GranCanaria': {'Lat': 27.92022, 'Long': -15.547437},
    'Harz': {'Lat': 51.809525, 'Long': 10.238361},
    'Holland': {'Lat': 52.132633, 'Long': 5.291266},
    'Ibiza': {'Lat': 38.906734, 'Long': 1.420598},
    'Ireland': {'Lat': 53.41291, 'Long': -8.24389},
    'LakeGarda': {'Lat': 45.604939, 'Long': 10.635141},
    'Lanzarote': {'Lat': 29.046854, 'Long': -13.589973},
    'Lolland': {'Lat': 54.727543, 'Long': 11.46493},
    'LowerAustria': {'Lat': 48.108077, 'Long': 15.804956},
    'Madeira': {'Lat': 32.760707, 'Long': -16.959472},
    'Mallorca': {'Lat': 39.695263, 'Long': 3.017571},
    'Malta': {'Lat': 35.937496, 'Long': 14.375416},
    'Morocco': {'Lat': 31.791702, 'Long': -7.09262},
    'Normandy': {'Lat': 48.87987, 'Long': 0.171253},
    'NorthSea': {'Lat': 56.511018, 'Long': 3.515625},
    'Poland': {'Lat': 51.919438, 'Long': 19.145136},
    'Rhodes': {'Lat': 36.434963, 'Long': 28.217483},
    'Riviera': {'Lat': 44.497152, 'Long': 8.953436},
    'SalzbergerLand': {'Lat': 47.80949, 'Long': 13.05501},
    'Salzkammergut': {'Lat': 47.7, 'Long': 13.58},
    'Scotland': {'Lat': 56.490671, 'Long': -4.202646},
    'Slowakei': {'Lat': 48.669026, 'Long': 19.699024},
    'Styria': {'Lat': 47.359344, 'Long': 14.469983},
    'Sweden': {'Lat': 60.128161, 'Long': 18.643501},
    'Teneriffe': {'Lat': 28.291564, 'Long': -16.62913},
    'Thuringia': {'Lat': 51.010989, 'Long': 10.845346},
    'Tunisia': {'Lat': 33.886917, 'Long': 9.537499},
    'TurkishAegeanSea': {'Lat': 39.050428, 'Long': 23.429984},
    'TurkishRiviera': {'Lat': 37.002553, 'Long': 28.015137},
    'Tyrol': {'Lat': 47.253741, 'Long': 11.601487},
    'Wales': {'Lat': 52.130661, 'Long': -3.783712}
}

fields_global = [
            'Duration',
            'Hotel name',
            'Number of persons',
            'Price',
            'Region'
        ]

drop_downs_global = {
    'Accommodation': [
        'Not important',
        'HolidayFlat',
        'OneStar',
        'TwoStars',
        'ThreeStars',
        'FourStars',
        'FiveStars'
    ],
    'Holiday type': [
        'Not important',
        'Active',
        'Skiing',
        'Surfing',
        'City',
        'Education',
        'Recreation',
        'Shopping',
        'Language',
        'Bathing',
        'Wandering',
        'Adventure',
        'Diving'
    ],
    'Season': [
        'Not important',
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
    ],
    'Transportation': [
        'Not important',
        'Car',
        'Plane',
        'Coach',
        'Train'
    ]
}


# Standard boilerplate to call the main() function to begin
# the program.
if __name__ == '__main__':
    main()
