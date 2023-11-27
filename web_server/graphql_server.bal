import ballerina/graphql;

@graphql:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service /sales on new graphql:Listener(9091) {
    resource function get orders() returns Response[]|error {
        Response[] res = check serviceClient->/sales/orders.get();
        return res;
    }
}
