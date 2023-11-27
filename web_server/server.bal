import ballerina/http;

final http:Client serviceClient = check new (url = "http://localhost:9093");

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service /sales on new http:Listener(9090) {

    resource function get orders() returns Order[]|http:InternalServerError {
        DesktopResponse[]|http:ClientError res = serviceClient->/sales/orders.get();
        if res is DesktopResponse[] {
            return from DesktopResponse entry in res
                select convertResponse(entry);
        }
        return http:INTERNAL_SERVER_ERROR;
    }

    resource function get orders/[string id]() returns Order|http:NotFound {
        DesktopResponse|http:ClientError res = serviceClient->/sales/orders/[id].get();
        if res is DesktopResponse {
            return convertResponse(res);
        }
        return http:NOT_FOUND;
    }

    resource function get customers/[string customerId]/orders(string status = "PENDING")
                            returns Order[]|http:InternalServerError {
        DesktopResponse[]|http:ClientError res =
                serviceClient->/sales/customers/[customerId]/orders.get(status = status);
        if res is DesktopResponse[] {
            return from DesktopResponse entry in res
                select convertResponse(entry);
        }
        return http:INTERNAL_SERVER_ERROR;
    };
}

function convertResponse(DesktopResponse desktopResponse) returns Order => {
    id: desktopResponse.id,
    shipId: desktopResponse.ship.shipId,
    date: desktopResponse.date,
    status: desktopResponse.status,
    item: desktopResponse.item.name,
    quantity: desktopResponse.quantity,
    customer: desktopResponse.customer.customerId
};
