import ballerina/http;

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

type Order record {
    readonly string id;
    Customer customer;
    Ship ship;
    string date;
    string status;
    int quantity;
    Item item;
};

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service /sales on new http:Listener(9092) {

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
}
