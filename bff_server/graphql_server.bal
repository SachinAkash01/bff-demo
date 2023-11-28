// import ballerina/http;
// import ballerina/graphql;

// final http:Client sClient = check new (url = "http://localhost:9093");

// @graphql:ServiceConfig {
//     graphiql: {
//         enabled: true
//     }
// }
// service /sales on new graphql:Listener(9095) {
//     resource function get orders() returns WebResponse[]|error {
//         BackendResponse[] res = check sClient->/sales/orders;
//         return from BackendResponse r in res select convertResponse(r);
//     }

//     resource function get getOrder(string id) returns WebResponse|error {
//         BackendResponse res = check sClient->/sales/orders/[id];
//         return convertResponse(res);
//     }
// }
