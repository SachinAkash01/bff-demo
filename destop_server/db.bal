final table<Order> key(id) orderTable = table [
    {
        "id": "HM-123",
        "customer": {
            "customerId": "C-742",
            "address": {
                "street": "123 Main St",
                "city": "San Francisco",
                "state": "CA",
                "zip": "94105"
            },
            "name": "John Doe",
            "email": "john@example.com"
        },
        "ship": {
            "shipId": "S-221",
            "destination": "Mexico",
            "startFrom": "San Francisco",
            "arrival": "2023-12-18"
        },
        "date": "2023-11-28",
        "status": "COMPLETED",
        "quantity": 8,
        "item": {
            "itemId": "I-123",
            "name": "iPhone 15",
            "price": 999.99
        }
    },
    {
        "id": "HM-253",
        "customer": {
            "customerId": "C-119",
            "address": {
                "street": "234 Main St",
                "city": "Washington",
                "state": "DC",
                "zip": "20001"
            },
            "name": "Jane Doe",
            "email": "jane@example.com"
        },
        "ship": {
            "shipId": "S-871",
            "destination": "London",
            "startFrom": "New York",
            "arrival": "2023-12-28"
        },
        "date": "2023-11-28",
        "status": "COMPLETED",
        "quantity": 7,
        "item": {
            "itemId": "I-547",
            "name": "TV",
            "price": 457.21
        }
    },
    {
        "id": "HM-643",
        "customer": {
            "customerId": "C-119",
            "address": {
                "street": "234 Main St",
                "city": "Washington",
                "state": "DC",
                "zip": "20001"
            },
            "name": "Jane Doe",
            "email": "jane@example.com"
        },
        "ship": {
            "shipId": "S-672",
            "destination": "London",
            "startFrom": "New York",
            "arrival": "2023-12-28"
        },
        "date": "2023-11-28",
        "status": "COMPLETED",
        "quantity": 7,
        "item": {
            "itemId": "I-547",
            "name": "TV",
            "price": 457.21
        }
    },
    {
        "id": "HM-901",
        "customer": {
            "customerId": "C-119",
            "address": {
                "street": "234 Main St",
                "city": "Washington",
                "state": "DC",
                "zip": "20001"
            },
            "name": "Jane Doe",
            "email": "jane@example.com"
        },
        "ship": {
            "shipId": "S-871",
            "destination": "London",
            "startFrom": "New York",
            "arrival": "2023-12-28"
        },
        "date": "2023-11-28",
        "status": "COMPLETED",
        "quantity": 7,
        "item": {
            "itemId": "I-547",
            "name": "TV",
            "price": 457.21
        }
    },
    {
        "id": "HM-265",
        "customer": {
            "customerId": "C-107",
            "address": {
                "street": "234 Main St",
                "city": "Washington",
                "state": "DC",
                "zip": "20001"
            },
            "name": "Mary Jane",
            "email": "Mary@example.com"
        },
        "ship": {
            "shipId": "S-888",
            "destination": "London",
            "startFrom": "New York",
            "arrival": "2023-12-28"
        },
        "date": "2023-11-28",
        "status": "CANCELLED",
        "quantity": 7,
        "item": {
            "itemId": "I-547",
            "name": "TV",
            "price": 457.21
        }
    }
];
