#!/usr/bin/env python

# import modules used here -- sys is a very standard one
# import sys
import openpyxl
import operator
# import time


# Gather our code in a main() function


def main():
    wb = openpyxl.load_workbook('travel.xlsx')
    sheet_names = wb.get_sheet_names()
    sheet_name = sheet_names[0]
    sheet = wb.get_sheet_by_name(sheet_name)
    # start_time = time.time()
    target_case = TargetCase()
    # target_case = TargetCase()
    load_cases(sheet, target_case)
    # indices = [i for i, x in enumerate(JourneyCase.personspercase) if x > 6]
    # print(JourneyCase.regions[12].region)
    # print(JourneyCase.holidaytypes)
    # print(JourneyCase.regions['Sweden,'].journeycode)
    # indices = get_cases_price_interval(800, 900)
    # codes = []
    # for val in indices:
    #     codes.append(val.journeycode)
    target_case.price = 5000
    print(JourneyCase.similarities()[0][0].price)
    target_case.price = 3000
    print(JourneyCase.similarities()[0][0].price)
    # print(JourneyCase.journeycodes[1024].similarity())
    # source_cases = JourneyCase.cases
    # cases = compare_cases(target_case, source_cases)
    # print(sorted(JourneyCase.similarities().items(), key=operator.itemgetter(1)))
    # print({}.fromkeys(JourneyCase.holidaytypes).keys())


class TargetCase:
    # target_price = 0
    #
    # @classmethod
    # def create(cls, case, journeycode, holidaytype,
    #         price, numberofpersons, region, transportation,
    #         duration, season, accommodation, hotel):
    #     instance = TargetCase(
    #         case, journeycode, holidaytype,
    #         price, numberofpersons, region, transportation,
    #         duration, season, accommodation, hotel)
    #     cls.target_price = instance.price

    def __init__(
            self, case=None, journeycode=None, holidaytype=None,
            price=None, numberofpersons=None, region=None, transportation=None,
            duration=None, season=None, accommodation=None, hotel=None):
        self.case = case
        self.journeycode = journeycode
        self.holidaytype = holidaytype
        self.price = price
        self.numberofpersons = numberofpersons
        self.region = region
        self.transportation = transportation
        self.duration = duration
        self.season = season
        self.accommodation = accommodation
        self.hotel = hotel


class JourneyCase:
    cases = {}
    journeycodes = {}
    holidaytypes = {}
    holidaylist = []
    prices = {}
    pricesdict = {}
    personspercase = []
    regions = {}
    price_range = 6882
    # target_price = 0
    # transportations = {}
    # durations = []
    # seasons = {}
    # accommodations = {}
    # hotels = {}

    @classmethod
    def create(
            cls, case, journeycode, holidaytype,
            price, numberofpersons, region, transportation,
            duration, season, accommodation, hotel, target_case):
        instance = JourneyCase(
            case, journeycode, holidaytype,
            price, numberofpersons, region, transportation,
            duration, season, accommodation, hotel, target_case)
        cls.cases[instance] = instance
        cls.journeycodes[journeycode] = instance
        if instance.holidaytype not in cls.holidaytypes:
            cls.holidaytypes[instance.holidaytype] = []
        cls.holidaytypes[instance.holidaytype].append(instance)
        cls.prices[instance] = instance.price
        cls.personspercase.append(instance.numberofpersons)
        cls.holidaylist.append(instance.holidaytype)
        cls.regions[region] = instance
        # cls.target_price = instance.target_case.price
        # cls.transportations[transportation] = instance
        # cls.durations[duration] = instance
        # cls.seasons[season] = instance
        # cls.accommodations[accommodation] = instance
        # cls.hotels[hotel] = instance
        return instance

    def __init__(
            self, case=None, journeycode=None, holidaytype=None,
            price=None, numberofpersons=None, region=None, transportation=None,
            duration=None, season=None, accommodation=None, hotel=None, target_case=TargetCase()):
        self.case = case
        self.journeycode = journeycode
        self.holidaytype = holidaytype
        self.price = price
        self.numberofpersons = numberofpersons
        self.region = region
        self.transportation = transportation
        self.duration = duration
        self.season = season
        self.accommodation = accommodation
        self.hotel = hotel
        self.target_case = target_case
        self.similarity()

    def similarity(self):
        sim_int = 0
        if self.target_case.price is not None:
            sim_int += self.price_sim()
        else:
            sim_int += 1
        return sim_int

    def price_sim(self):
        return (self.price_range - abs(self.target_case.price - self.price)) / self.price_range

    @classmethod
    def similarities(cls):
        similarities = {}
        for instance in cls.cases:
            similarities[instance] = instance.similarity()
        return sorted(similarities.items(), key=operator.itemgetter(1), reverse=True)


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
                case[0], case[1], case[2], case[3],
                case[4], case[5], case[6], case[7],
                case[8], case[9], case[10], target_case)
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


def compare_cases(target_case, source_cases):
    similar_cases = {}
    if target_case.price is not None:
        for case in source_cases:
            range_prices = JourneyCase.price_range[1] - JourneyCase.price_range[0]
            diff = abs(target_case.price - case.price)
            similarity = (range_prices - diff)/range_prices
            similar_cases[case.journeycode] = similarity
            # if target_case.price == case.price:
            #     return case.journeycode
            # print(case)
        return similar_cases
    else:
        return None


def remove_key(d, key):
    r = dict(d)
    del r[key]
    return r


# Standard boilerplate to call the main() function to begin
# the program.
if __name__ == '__main__':
    main()
