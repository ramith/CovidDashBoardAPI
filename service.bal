import ballerinax/covid19;
import ballerina/log;
import ballerina/http;

# Status of the country
type CountryStatus record {
    string country;
    decimal activeCases;
};

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    # Provides country information
    # + return - country information 
    resource function get status/[string countryCode]() returns CountryStatus| error? {

        log:printInfo("new request: " + countryCode);
        covid19:Client covid19Endpoint = check new ({});
        covid19:CovidCountry getStatusByCountryResponse = check covid19Endpoint->getStatusByCountry(countryCode);
        CountryStatus status = {country: countryCode, activeCases: getStatusByCountryResponse.active};

        return status;
    }
}
