public class AirlineFlightDetails {
    
    @AuraEnabled
    public static List<Flight_Details__c> getFlightDetails () {
        return [Select Id,Name, Flight_Name__c, Flight_Departure_Time__c, Flight_Arrival_Time__c,Duration__c from
                Flight_Details__c LIMIT 10];
    }
    
    @AuraEnabled
    public static Id insertReservation(String flightName, String passportNumber, 
                                       String address, String state, 
                                       Integer noofSeats,String email,
                                       String passengerName, String flightBooked){
                                           System.debug('FlightName::'+flightName+'~'+'Passport Number::'+passportNumber
                                                        +'~'+'Address::'+address+'~'+'noofSeats:::'+noofSeats+'~'+'Email::'+email
                                                        +'~ PassengerName:::'+passengerName+'~'+'Flight Booked:::'+flightBooked);
                                           Passenger__c pObj= new Passenger__c();
                                           try {
                                               pObj.Address__c=address;
                                               pObj.Email__c=email;
                                               pObj.Flight_Booked__c=flightBooked;
                                               pObj.Number_of_Seats__c=noofSeats;
                                               pObj.Passenger_Name__c=passengerName;
                                               pObj.Passport_Number__c=passportNumber;
                                               pObj.State__c=state;
                                               insert pObj;
                                           }
                                           catch(Exception e){
                                               
                                           }
                                           System.debug('Inserted Reservation:::'+pObj.Id);
                                           return pObj.Id;
                                       }
}