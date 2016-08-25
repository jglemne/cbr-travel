#!/usr/local/bin/python3.5

import psycopg2
import re


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


def get_cases_price_interval(lowest_price, highest_price, my_dict):
    indices = []
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


def hamming_distance(s1, s2):
    if len(s1) != len(s2):
        raise ValueError("Undefined for sequences of unequal length")
    return sum(el1 != el2 for el1, el2 in zip(s1, s2))


def sortby(tree, col, descending):
    # grab values to sort
    data = [(tree.set(child, col), child) for child in tree.get_children('')]
    # if the data to be sorted is numeric change to float
    try:
        data = change_numeric(data)
    except ValueError:
        pass
    # now sort the data in place
    data.sort(reverse=descending)
    for ix, item in enumerate(data):
        tree.move(item[1], '', ix)
    # switch the heading so it will sort in the opposite direction
    tree.heading(col, command=lambda col=col: sortby(tree, col, int(not descending)))


def change_numeric(data):
    float_list = []
    for data_tuple in data:
        new_float = float(data_tuple[0])
        new_tuple = (new_float, data_tuple[1])
        float_list.append(new_tuple)
    return float_list


def fixed_list(number_of_elements):
    x = [None] * number_of_elements
    for i in range(number_of_elements):
        x[i] = i
    return x
