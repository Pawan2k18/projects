//
//  StructOperation.swift
//  Travanada2
//
//  Created by Pawan Dey on 05/07/19.
//  Copyright © 2019 nibble. All rights reserved.
//

class StructOperation {
    struct bookingRef {
        static var bookingid = String()
    }
    
    struct glovalVariable {
        static var checkin = String();
        static var checkout = String();
        static var totalroom = String();
        static var totalguest = Int();
        static var hotelFare = String();
        static var location = String();
        static var guestDeatils = String();
        static var hotelname = String();
        static var hotelAddressCity = String();
        static var adult = String();
        static var child = String();
    }
    
    struct flightDetails {
        static var from = String();
        static var to = String();
        static var departDate = String();
        static var returnDate = String();
        static var adults = String();
        static var children = String();
        static var infants = String();
        static var classtype = String();
        static var totalTraveller = Int();
        static var totalfare = String();
        static var passengerDetails = String();
        static var flightType = String();
        
    }
    
    struct FlightOrHotel {
        static var comingfrom = String();
    }
    
    
    struct tripType{
        static var trip = String();
    }
    
    struct Passengers{
        static var adult = String();
        static var child = String();
        static var infant = String();
        static var classtype = String();
    }
    
    struct TotalFareForPayment{
        static var totalFare = Double();
    }
    
}
