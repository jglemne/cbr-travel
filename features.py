import psycopg2
from geopy.geocoders import Nominatim
from geopy.exc import GeocoderServiceError
from globals import adaptables
from tools import do_geocode


class Accommodation:
    indices = {'HolidayFlat': 1, 'OneStar': 2, 'TwoStars': 3, 'ThreeStars': 4, 'FourStars': 5, 'FiveStars': 6}
    adaptable = adaptables['Accommodation']

    def __init__(self, accommodation=None):
        self.name = accommodation
        self.index = self.indices.get(accommodation)


class Duration:
    adaptable = adaptables['Duration']

    def __init__(self, duration=None):
        self.days = duration


class HolidayType:
    groups = {
        'Arbitrary': '0000000', 'Active': '0001001', 'City': '0010010', 'Education': '0011011',
        'Recreation': '0100100', 'Shopping': '0101010', 'Language': '0110011', 'Bathing': '0111100',
        'Wandering': '1000100', 'Adventure': '1001001', 'Diving': '1010001', 'Skiing': '1011001',
        'Surfing': '1100001'
    }
    adaptable = adaptables['Holiday type']

    def __init__(self, holiday_type=None):
        self.name = holiday_type
        self.group = self.groups.get(holiday_type)


class Hotel:
    adaptable = adaptables['Hotel']

    def __init__(self, hotel=None):
        self.name = hotel


class JourneyCode:
    # weight = weights_global['Journey code']
    adaptable = adaptables['Journey code']

    def __init__(self, journey_code=None):
        self.number = journey_code


class NumberOfPersons:
    adaptable = adaptables['Number of persons']

    def __init__(self, number_of_persons=None):
        self.total = number_of_persons


class Price:
    adaptable = adaptables['Price']

    def __init__(self, price=None, number_of_persons=None):
        self.total = price
        if number_of_persons is not None:
            self.per_person = price/number_of_persons
        else:
            self.per_person = None


class Region:
    adaptable = adaptables['Region']
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
            geo_locator = Nominatim()
            try:
                location = do_geocode(region, geo_locator)
                new_longitude = location.longitude
                new_latitude = location.latitude
                self.regions[region]['Long'] = new_longitude
                self.regions[region]['Lat'] = new_latitude
                cur.execute("INSERT INTO regions (region_name,latitude,longitude) VALUES (%s,%s,%s)",
                            (region, new_latitude, new_longitude))
                conn.commit()
            except (GeocoderServiceError, AttributeError) as e:
                print("Error: Failed to find region %s with message %s" % (region, e))
        else:
            self.regions[region]['Lat'] = result[0][0]
            self.regions[region]['Long'] = result[0][1]


class Season:
    adaptable = adaptables['Season']
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
    adaptable = adaptables['Transportation']
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


class Weights:
    integers = {
        'Accommodation': 3,
        'Duration': 2,
        'Holiday type': 10,
        'Hotel': 20,
        'Journey code': 200,
        'Number of persons': 2,
        'Price': 7,
        'Region': 2,
        'Season': 4,
        'Transportation': 4
    }

    def __init__(self):
        self.accommodation = self.integers['Accommodation']
        self.duration = self.integers['Duration']
        self.holiday_type = self.integers['Holiday type']
        self.hotel = self.integers['Hotel']
        self.journey_code = self.integers['Journey code']
        self.number_of_persons = self.integers['Number of persons']
        self.price = self.integers['Price']
        self.region = self.integers['Region']
        self.season = self.integers['Season']
        self.transportation = self.integers['Transportation']

    def set_weights(self):
        self.accommodation = self.integers['Accommodation']
        self.duration = self.integers['Duration']
        self.holiday_type = self.integers['Holiday type']
        self.hotel = self.integers['Hotel']
        self.journey_code = self.integers['Journey code']
        self.number_of_persons = self.integers['Number of persons']
        self.price = self.integers['Price']
        self.region = self.integers['Region']
        self.season = self.integers['Season']
        self.transportation = self.integers['Transportation']
