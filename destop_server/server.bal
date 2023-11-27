import ballerina/http;
import ballerina/random;

type Location record {|
    float latitude;
    float longitude;
|};

type Address record {|
    string street;
    string city;
    string state;
    string zip;
|};

type Customer record {|
    string customerId;
    Address address;
    string name;
    string email;
|};

type Ship record {|
    string shipId;
    string destination;
    string startFrom;
    string arrival;
|};

type Item record {|
    string itemId;
    string name;
    decimal price;
|};

type Order record {|
    readonly string id;
    Customer customer;
    Ship ship;
    string date;
    string status;
    int quantity;
    Item item;
|};

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service /sales on new http:Listener(9093) {

    resource function get orders() returns Order[] {
        return orderTable.toArray();
    }
    resource function get orders/[string id]() returns Order|http:NotFound {
        return orderTable[id] ?: <http:NotFound>{
            body: string `Order not found. Order ID: ${id}`
        };
    };

    resource function get customers/[string customerId]/orders(string status = "PENDING") returns Order[] {
        return from Order entry in orderTable
            where entry.customer.customerId == customerId && entry.status == status
            select entry;
    };

    resource function get orders/locations() returns Location|error {
        return {
            latitude: check random:createIntInRange(668700, 1246700) * 1.0 / 10000.0,
            longitude: check random:createIntInRange(258400, 493800) * 1.0 / 10000.0
        };
    }
}
