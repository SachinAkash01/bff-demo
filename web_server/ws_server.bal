import ballerina/lang.runtime;
import ballerina/log;
import ballerina/random;
import ballerina/websocket;

type Location record {|
    float latitude;
    float longitude;
|};

service /logistics on new websocket:Listener(9092) {
    resource function get vehicles/[string orderId]() returns websocket:Service {
        return new LocationService(orderId);
    }
}

distinct service class LocationService {
    *websocket:Service;
    private final string orderId;

    function init(string orderId) {
        self.orderId = orderId;
    }

    remote function onOpen(websocket:Caller caller) returns error? {
        // Create a new strand and allocate it to send the locations to the client 
        _ = start self.routeLocationFromServerToClient(caller, self.orderId);
        return;
    }

    function routeLocationFromServerToClient(websocket:Caller caller, string orderId) returns error? {
        while true {
            Location currentLocation = {
                latitude: check random:createIntInRange(668700, 1246700) * 1.0 / 10000.0,
                longitude: check random:createIntInRange(258400, 493800) * 1.0 / 10000.0
            };
            log:printInfo("Sending location of order " + orderId + " to client: " + currentLocation.toBalString());
            check caller->writeMessage(currentLocation);
            runtime:sleep(3);
        }
    }
}
