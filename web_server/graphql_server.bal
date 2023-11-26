import ballerina/http;
import ballerina/graphql;

final http:Client sClient = check new (url = "http://localhost:9092");

service /sales on new graphql:Listener(9091) {

    resource function get orders() returns Order[]|error {
        DesktopResponse[] res = check sClient->/orders.get();
        return from DesktopResponse r in res select convertResponse(r);
    }

    resource function get getOrder(string id) returns Order|error {
        DesktopResponse res = check sClient->/orders/[id].get();
        return convertResponse(res);
    }

    resource function get customerOrders(string customerId, string status = "PENDING") returns Order[]|error {
        DesktopResponse[] res = check sClient->/customers/[customerId]/orders.get(status = status);
        return from DesktopResponse r in res select convertResponse(r);
    };
}
