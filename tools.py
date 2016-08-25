#!/usr/local/bin/python3.5

import psycopg2
import re
from geopy.exc import GeocoderTimedOut


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


def do_geocode(region, geo_locator):
    try:
        return geo_locator.geocode(region)
    except GeocoderTimedOut:
        return do_geocode(region, geo_locator)
