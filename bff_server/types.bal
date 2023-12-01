
type Order record {
    string id;
    string customer;
    string shipId;
    string date;
    string status;
    int quantity;
    string item;
};

type Address record {
    string street;
    string city;
    string state;
    string zip;
};

type Customer record {
    string customerId;
    Address address;
    string name;
    string email;
};

type Ship record {
    string shipId;
    string destination;
    string startFrom;
    string arrival;
};

type Item record {
    string itemId;
    string name;
    decimal price;
};

type BackendResponse record {
    string id;
    Customer customer;
    Ship ship;
    string date;
    string status;
    int quantity;
    Item item;
};
