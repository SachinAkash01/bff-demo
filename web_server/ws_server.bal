import ballerina/websocket;
import ballerina/random;
import ballerina/lang.runtime;

service /logistics on new websocket:Listener(9092) {
    resource function get .(string vehicleId) returns websocket:Service {
        return new LocationService(vehicleId);
    }
}

distinct service class LocationService {
    *websocket:Service;

    private final string vehicleId;

    function init(string vehicleId) {
        self.vehicleId = vehicleId;
    }

    remote function onOpen(websocket:Caller caller) returns error? {
        // Create a new strand  and allocate it to send the locations to the client 
        _ = start self.routeLocationFromServerToClient(caller, self.vehicleId);
        return;
    }

    function routeLocationFromServerToClient(websocket:Caller caller, string vehicleId) returns error? {
        while true {
            Location currentLocation = {
                latitude: check random:createIntInRange(668700, 1246700) * 1.0 / 10000.0,
                longitude: check random:createIntInRange(258400, 493800) * 1.0 / 10000.0
            };
            check caller->writeMessage(currentLocation);
            runtime:sleep(3);
        }
    }
}