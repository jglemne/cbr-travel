fields_global = [
            'Duration',
            'Hotel',
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

weights_global = {
    'Accommodation': 3,
    'Duration': 1,
    'Holiday type': 10,
    'Hotel': 20,
    'Journey code': 200,
    'Number of persons': 2,
    'Price': 7,
    'Region': 2,
    'Season': 4,
    'Transportation': 4
}

algorithm = {
    'fast': False,
    'adapt': False,
    'key cases': 6
}

adaptables = {
    'Accommodation': False,
    'Duration': True,
    'Holiday type': False,
    'Hotel': False,
    'Journey code': False,
    'Number of persons': True,
    'Price': True,
    'Region': False,
    'Season': False,
    'Transportation': False
}
