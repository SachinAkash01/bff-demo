
type Order record {
    string id;
    string customer;
    string shipId;
    string date;
    string status;
    int quantity;
    string item;
};

type DesktopResponse record {
    string id;
    record {
        string customerId;
        record {
            string street;
            string city;
            string state;
            string zip;
        } address;
        string name;
        string email;
    } customer;
    record {
        string shipId;
        string destination;
        string startFrom;
        string arrival;
    } ship;
    string date;
    string status;
    int quantity;
    record {
        string itemId;
        string name;
        decimal price;
    } item;
};
