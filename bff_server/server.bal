import ballerina/http;

final http:Client serviceClient = check new (url = "http://localhost:9093");

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service /sales on new http:Listener(9090) {

    resource function get orders() returns Order[]|http:InternalServerError {
        BackendResponse[]|http:ClientError res = serviceClient->/sales/orders.get();
        if res is BackendResponse[] {
            return from BackendResponse entry in res
                select convertResponse(entry);
        }
        return http:INTERNAL_SERVER_ERROR;
    }

    resource function get orders/[string id]() returns Order|http:NotFound {
        BackendResponse|http:ClientError res = serviceClient->/sales/orders/[id].get();
        if res is BackendResponse {
            return convertResponse(res);
        }
        return http:NOT_FOUND;
    }

    resource function get customers/[string customerId]/orders(string status = "PENDING")
                            returns Order[]|http:InternalServerError {
        BackendResponse[]|http:ClientError res =
                serviceClient->/sales/customers/[customerId]/orders.get(status = status);
        if res is BackendResponse[] {
            return from BackendResponse entry in res
                select convertResponse(entry);
        }
        return http:INTERNAL_SERVER_ERROR;
    };
}

function convertResponse(BackendResponse backendResponse) returns Order => {
    id: backendResponse.id,
    shipId: backendResponse.ship.shipId,
    date: backendResponse.date,
    status: backendResponse.status,
    item: backendResponse.item.name,
    quantity: backendResponse.quantity,
    customer: backendResponse.customer.customerId
};
