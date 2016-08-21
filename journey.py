#!/usr/bin/env python

# import modules used here -- sys is a very standard one
# import sys
import openpyxl
import operator
import time


# Gather our code in a main() function


def main():
    wb = openpyxl.load_workbook('travel.xlsx')
    sheet_names = wb.get_sheet_names()
    sheet_name = sheet_names[0]
    sheet = wb.get_sheet_by_name(sheet_name)
    target_case = TargetCase(holiday_type='Active', accommodation='FiveStars')
    load_cases(sheet, target_case)
    target_case.price = 5000
    # print(JourneyCase.similarities()[0])
    target_case.price = 500
    print(JourneyCase.similarities()[:10])
    start_time = time.time()
    print(JourneyCase.similarities()[0][0].journey_code)
    # holiday_type = HolidayType('Active')
    # print(holiday_type.groups['Shopping,'])
    # # print(JourneyCase.holiday_types['Active,'])
    print("--- %s seconds ---" % (time.time() - start_time))
    # # print("{0:b}".format(0b1010001 & 0b1000001))


class Accommodation:
    indices = {'HolidayFlat': 0, 'OneStar': 1, 'TwoStars': 2, 'ThreeStars': 3, 'FourStars': 4, 'FiveStars': 5}
    weight = 1

    def __init__(self, accommodation=None):
        self.name = accommodation
        self.index = self.indices.get(accommodation)


class HolidayType:
    groups = {
        'Arbitrary': '0000000', 'Active': '0001001', 'City': '0010010', 'Education': '0011011',
        'Recreation': '0100100', 'Shopping': '0101010', 'Language': '0110011', 'Bathing': '0111100',
        'Wandering': '1000100', 'Adventure': '1001001', 'Diving': '1010001', 'Skiing': '1011001',
        'Surfing': '1100001'
    }
    weight = 1

    def __init__(self, holiday_type=None):
        self.name = holiday_type
        self.group = self.groups.get(holiday_type)


class TargetCase:

    def __init__(
            self, case=None, journey_code=None, holiday_type=None,
            price=None, number_of_persons=None, region=None, transportation=None,
            duration=None, season=None, accommodation=None, hotel=None):
        self.case = case
        self.journey_code = journey_code
        self.holiday_type = HolidayType(holiday_type)
        self.price = price
        self.number_of_persons = number_of_persons
        self.region = region
        self.transportation = transportation
        self.duration = duration
        self.season = season
        self.accommodation = Accommodation(accommodation)
        self.hotel = hotel


class JourneyCase:
    cases = {}
    journey_codes = {}
    holiday_types = {}
    holiday_list = []
    prices = {}
    prices_dict = {}
    persons_per_case = []
    regions = {}
    price_range = [279, 7161]
    # target_price = 0
    # transportations = {}
    durations = []
    # seasons = {}
    # accommodations = {}
    # hotels = {}

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
        cls.journey_codes[journey_code] = instance
        if instance.holiday_type not in cls.holiday_types:
            cls.holiday_types[instance.holiday_type] = []
        cls.holiday_types[instance.holiday_type].append(instance)
        cls.prices[instance] = instance.price
        cls.persons_per_case.append(instance.number_of_persons)
        # cls.holiday_list.append(instance.holiday_type)
        cls.regions[region] = instance
        # cls.target_price = instance.target_case.price
        # cls.transportations[transportation] = instance
        cls.durations.append(duration)
        # cls.seasons[season] = instance
        # cls.accommodations[accommodation] = instance
        # cls.hotels[hotel] = instance
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
        self.case = case
        self.journey_code = journey_code
        self.holiday_type = HolidayType(holiday_type)
        self.price = price
        self.number_of_persons = number_of_persons
        self.region = region
        self.transportation = transportation
        self.duration = duration
        self.season = season
        self.accommodation = Accommodation(accommodation)
        self.hotel = hotel
        self.target_case = target_case
        self.similarity()

    def similarity(self):
        sim_int = 0
        total_weight = 0
        if self.target_case.price is not None:
            sim_int += self.price_sim()
            total_weight += 1
        else:
            sim_int += 1
            total_weight += 1
        if self.target_case.holiday_type.name is not None:
            sim_int += self.holiday_type_sim()
            total_weight += self.holiday_type.weight
        else:
            sim_int += 1
            total_weight += 1
        if self.target_case.accommodation.name is not None:
            sim_int += self.accommodation_sim()
            total_weight += self.target_case.accommodation.weight
        else:
            sim_int += 1
            total_weight += 1
        return sim_int/total_weight

    def price_sim(self):
        if self.price <= self.target_case.price:
            return 1
        else:
            return (self.price_range[1] - self.price)/(self.price_range[1] - self.price_range[0])

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

    def accommodation_sim(self):
        if self.accommodation.index >= self.target_case.accommodation.index:
            return 1
        else:
            return self.accommodation.index/self.target_case.accommodation.index


def load_cases(sheet, target_case):
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
                case[4], case[5], case[6], case[7],
                case[8], case[9].replace(',', ''), case[10], target_case)
        case_row += 16


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


# Standard boilerplate to call the main() function to begin
# the program.
if __name__ == '__main__':
    main()
