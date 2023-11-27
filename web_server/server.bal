import ballerina/http;

final http:Client serviceClient = check new (url = "http://localhost:9093");

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service /sales on new http:Listener(9090) {
    resource function get customers/[string customerId]/orders(string status = "PENDING")
                            returns Order[]|http:InternalServerError {
        Response[]|http:ClientError res =
                serviceClient->/sales/customers/[customerId]/orders.get(status = status);
        if res is Response[] {
            return from Response entry in res
                select convertResponse(entry);
        }
        return http:INTERNAL_SERVER_ERROR;
    };
}

function convertResponse(Response response) returns Order => {
    id: response.id,
    shipId: response.ship.shipId,
    date: response.date,
    status: response.status,
    item: response.item.name,
    quantity: response.quantity,
    customer: response.customer.customerId
};
