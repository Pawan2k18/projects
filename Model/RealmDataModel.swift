//
//  RealmDataModel.swift
//  Travanada2
//
//  Created by Pawan Dey on 29/08/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class BookingID:Object{
     @objc dynamic var bookingref = ""
}

class PaymentDeatils:Object{
    @objc dynamic var cardNumber = ""
    @objc dynamic var expMonth = ""
    @objc dynamic var expYear = ""
    @objc dynamic var cvv = ""
    @objc dynamic var holdername = ""
    @objc dynamic var totalFare:Double = 0.0
}

// Model class for flight data
class FlightData: Object {
    
    @objc dynamic var from = ""
    @objc dynamic var to = ""
    @objc dynamic var jdate = ""
    @objc dynamic var rdate = ""
    @objc dynamic var flightType = ""
    @objc dynamic var classtype = ""
    @objc dynamic var adult = ""
    @objc dynamic var child = ""
    @objc dynamic var infant = ""
    @objc dynamic var flightFare = ""
    @objc dynamic var passengerDeatils = ""
    @objc dynamic var totalTraveller:Int = 1
    
}

// Model class for hotel data
class HotelData: Object {
    @objc dynamic var hotelname = ""
    @objc dynamic var location = ""
    @objc dynamic var checkin = ""
    @objc dynamic var checkout = ""
    @objc dynamic var room = ""
    @objc dynamic var adult = ""
    @objc dynamic var child = ""
    @objc dynamic var guest = ""
    @objc dynamic var hotelfare = ""
    @objc dynamic var totalGuest:Int = 1
    @objc dynamic var guestDeatils = ""
}
