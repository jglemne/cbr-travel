#!/usr/bin/env python

# import modules used here -- sys is a very standard one
# import sys
import openpyxl
# import time


# Gather our code in a main() function


def main():
    wb = openpyxl.load_workbook('travel.xlsx')
    sheet_names = wb.get_sheet_names()
    sheet_name = sheet_names[0]
    sheet = wb.get_sheet_by_name(sheet_name)
    # start_time = time.time()
    load_cases(sheet)
    # indices = [i for i, x in enumerate(JourneyCase.personspercase) if x > 6]
    print({}.fromkeys(JourneyCase.holidaytypes).keys())


class JourneyCase:
    cases = {}
    journeycodes = {}
    holidaytypes = {}
    holidaylist = []
    prices = []
    personspercase = []
    # regions = {}
    # transportations = {}
    # durations = []
    # seasons = {}
    # accommodations = {}
    # hotels = {}

    @classmethod
    def create(
            cls, case, journeycode, holidaytype,
            price, numberofpersons, region, transportation,
            duration, season, accommodation, hotel):
        instance = JourneyCase(
            case, journeycode, holidaytype,
            price, numberofpersons, region, transportation,
            duration, season, accommodation, hotel)
        cls.cases[case] = instance
        cls.journeycodes[journeycode] = instance
        cls.holidaytypes[holidaytype] = instance
        cls.prices.append(instance.price)
        cls.personspercase.append(instance.numberofpersons)
        cls.holidaylist.append(instance.holidaytype)
        # cls.regions[region] = instance
        # cls.transportations[transportation] = instance
        # cls.durations[duration] = instance
        # cls.seasons[season] = instance
        # cls.accommodations[accommodation] = instance
        # cls.hotels[hotel] = instance
        return instance

    def __init__(
            self, case, journeycode, holidaytype,
            price, numberofpersons, region, transportation,
            duration, season, accommodation, hotel):
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


def load_cases(sheet):
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
                case[8], case[9], case[10])
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


def repeat(s, exclaim):
    """
    Returns the string 's' repeated 3 times.
    If exclaim is true, add exclamation marks.
    """

    result = s + ' ' + s + ' ' + s  # can also use "s * 3" which is faster (Why?)
    if exclaim:
        result = str(result) + '!!!'
    return result

# Standard boilerplate to call the main() function to begin
# the program.
if __name__ == '__main__':
    main()
