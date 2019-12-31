//
//  HotelSearchModel.swift
//  Travanada2
//
//  Created by Pawan Dey on 11/06/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import Foundation
import SwiftyJSON

// MARK: - HotelSearch
class HotelSearch {
    var type = ""
    var available = ""
    
    var hotel = Hotel()
    var arrOffers = [Offers]()
    
    init(){
    }
    
    func setdata(dictJson: [String: JSON]) {
        type = dictJson["type"]?.stringValue ?? ""
        available = dictJson["available"]?.stringValue ?? ""
        hotel.setdata(dictJson: dictJson["hotel"]?.dictionaryValue ?? [:])
        
        for dictOffer in dictJson["offers"]!.arrayValue {
            let data = Offers()
            data.setdata(dictJson: dictOffer.dictionaryValue)
            self.arrOffers.append(data)
        }
    }
    
}

// MARK: - Offers
class Offers {
    var id = ""
    var rateCode = ""
    var boardType = ""
    //var description = Description()
     //var room = Room()
     //var guests = Guests()
     //var price = Price()
    
    init(){
    }
    
    func setdata(dictJson: [String: JSON]) {
        id = dictJson["id"]?.stringValue ?? ""
        rateCode = dictJson["rateCode"]?.stringValue ?? ""
        boardType = dictJson["boardType"]?.stringValue ?? ""
        
        
        //description.setdata(dictJson: dictJson["description"]?.dictionaryValue ?? [:])
        
        //room.setdata(dictJson: dictJson["room"]?.dictionaryValue ?? [:])
        
        //guests.setdata(dictJson: dictJson["guests"]?.dictionaryValue ?? [:])

        //price.setdata(dictJson: dictJson["price"]?.dictionaryValue ?? [:])
        
    }
    
}


// MARK: - Hotel
class Hotel {
    
    var type = ""
    var hotelId = ""
    var chainCode = ""
    var brandCode = ""
    var dupeID = ""
    var name = ""
    var rating = ""
    var cityCode = ""
    var latitude = ""
    var longitude = ""
    //var hotelDistance = HotelDistance()
    var address = Address()
    //var contact = Contact()
    //var hotelDescription = Description()
    var amenities = ""
    //var media = [Media]()
    
    init(){
    }
    
    func setdata(dictJson: [String: JSON]){
        type = dictJson["type"]?.stringValue ?? ""
        hotelId = dictJson["hotelId"]?.stringValue ?? ""
        chainCode = dictJson["chainCode"]?.stringValue ?? ""
        dupeID = dictJson["dupeID"]?.stringValue ?? ""
        name = dictJson["name"]?.stringValue ?? ""
        rating = dictJson["rating"]?.stringValue ?? ""
        cityCode = dictJson["cityCode"]?.stringValue ?? ""
        latitude = dictJson["latitude"]?.stringValue ?? ""
        longitude = dictJson["longitude"]?.stringValue ?? ""
        
        address.setdata(dictJson: dictJson["address"]?.dictionaryValue ?? [:])
    }
}


//// MARK: - Address
class Address {
    var cityName = ""
    var postalCode = ""
    var countryCode = ""
    
    init() {
    }
    
    func setdata(dictJson: [String: JSON]){
        cityName = dictJson["cityName"]?.stringValue ?? ""
        postalCode = dictJson["postalCode"]?.stringValue ?? ""
        countryCode = dictJson["countryCode"]?.stringValue ?? ""
    }
    
}


// MARK: - Description
class Description {
    var lang = ""
    var text = ""
    
    init(){
        
    }
    
}




//
//enum CityName {
//    case paris
//}
//
//enum CountryCode {
//    case fr
//}
//
//enum CityCode {
//    case ory
//    case par
//}
//
//// MARK: - Contact
//class Contact {
//    let phone, fax: String
//    let email: String?
//
//    init(phone: String, fax: String, email: String?) {
//        self.phone = phone
//        self.fax = fax
//        self.email = email
//    }
//}
//
//
//enum Lang {
//    case en
//    case langEN
//}
//
//// MARK: - HotelDistance
//class HotelDistance {
//    let distance: Double
//    let distanceUnit: DistanceUnit
//
//    init(distance: Double, distanceUnit: DistanceUnit) {
//        self.distance = distance
//        self.distanceUnit = distanceUnit
//    }
//}
//
//enum DistanceUnit {
//    case km
//}
//
//// MARK: - Media
//class Media {
//    let uri: String
//    let category: MediaCategory
//
//    init(uri: String, category: MediaCategory) {
//        self.uri = uri
//        self.category = category
//    }
//}
//
//enum MediaCategory {
//    case exterior
//    case lobby
//    case room
//}
//
//enum HotelType {
//    case hotel
//}
//
//// MARK: - Offer
//class Offer {
//    let id, rateCode: String
//    let rateFamilyEstimated: RateFamilyEstimated?
//    let commission: Commission?
//    let room: Room
//    let guests: Guests
//    let price: Price
//    let policies: Policies?
//
//    init(id: String, rateCode: String, rateFamilyEstimated: RateFamilyEstimated?, commission: Commission?, room: Room, guests: Guests, price: Price, policies: Policies?) {
//        self.id = id
//        self.rateCode = rateCode
//        self.rateFamilyEstimated = rateFamilyEstimated
//        self.commission = commission
//        self.room = room
//        self.guests = guests
//        self.price = price
//        self.policies = policies
//    }
//}
//
//// MARK: - Commission
//class Commission {
//    let percentage: String
//
//    init(percentage: String) {
//        self.percentage = percentage
//    }
//}
//
//// MARK: - Guests
//class Guests {
//    let adults: Int
//
//    init(adults: Int) {
//        self.adults = adults
//    }
//}
//
//// MARK: - Policies
//class Policies {
//    let deposit: Deposit?
//    let cancellation: Cancellation?
//    let guarantee: Deposit?
//    let holdTime: HoldTime?
//
//    init(deposit: Deposit?, cancellation: Cancellation?, guarantee: Deposit?, holdTime: HoldTime?) {
//        self.deposit = deposit
//        self.cancellation = cancellation
//        self.guarantee = guarantee
//        self.holdTime = holdTime
//    }
//}
//
//// MARK: - Cancellation
//class Cancellation {
//    let deadline: String
//    let numberOfNights: Int?
//    let type: String?
//
//    init(deadline: String, numberOfNights: Int?, type: String?) {
//        self.deadline = deadline
//        self.numberOfNights = numberOfNights
//        self.type = type
//    }
//}
//
//// MARK: - Deposit
//class Deposit {
//    let acceptedPayments: AcceptedPayments
//
//    init(acceptedPayments: AcceptedPayments) {
//        self.acceptedPayments = acceptedPayments
//    }
//}
//
//// MARK: - AcceptedPayments
//class AcceptedPayments {
//    let creditCards: [CreditCard]?
//    let methods: [Method]
//
//    init(creditCards: [CreditCard]?, methods: [Method]) {
//        self.creditCards = creditCards
//        self.methods = methods
//    }
//}
//
//enum CreditCard {
//    case ax
//    case ca
//    case dc
//    case dn
//    case jc
//    case mc
//    case vi
//}
//
//enum Method {
//    case creditCard
//    case travelAgentID
//}
//
//// MARK: - HoldTime
//class HoldTime {
//    let deadline: String
//
//    init(deadline: String) {
//        self.deadline = deadline
//    }
//}
//
//// MARK: - Price
//class Price {
//    let currency: Currency
//    let total: String
//    let variations: Variations
//    let base: String?
//
//    init(currency: Currency, total: String, variations: Variations, base: String?) {
//        self.currency = currency
//        self.total = total
//        self.variations = variations
//        self.base = base
//    }
//}
//
//enum Currency {
//    case eur
//}
//
//// MARK: - Variations
//class Variations {
//    let average: Average?
//    let changes: [Change]
//
//    init(average: Average?, changes: [Change]) {
//        self.average = average
//        self.changes = changes
//    }
//}
//
//// MARK: - Average
//class Average {
//    let total, base: String?
//
//    init(total: String?, base: String?) {
//        self.total = total
//        self.base = base
//    }
//}
//
//// MARK: - Change
//class Change {
//    let startDate, endDate: String
//    let total, base: String?
//
//    init(startDate: String, endDate: String, total: String?, base: String?) {
//        self.startDate = startDate
//        self.endDate = endDate
//        self.total = total
//        self.base = base
//    }
//}
//
//// MARK: - RateFamilyEstimated
//class RateFamilyEstimated {
//    let code: String
//    let type: RateFamilyEstimatedType
//
//    init(code: String, type: RateFamilyEstimatedType) {
//        self.code = code
//        self.type = type
//    }
//}
//
//enum RateFamilyEstimatedType {
//    case c
//    case p
//}
//
//// MARK: - Room
//class Room {
//    let type: String
//    let typeEstimated: TypeEstimated?
//    let roomDescription: Description
//
//    init(type: String, typeEstimated: TypeEstimated?, roomDescription: Description) {
//        self.type = type
//        self.typeEstimated = typeEstimated
//        self.roomDescription = roomDescription
//    }
//}
//
//// MARK: - TypeEstimated
//class TypeEstimated {
//    let category: TypeEstimatedCategory
//    let beds: Int?
//    let bedType: String?
//
//    init(category: TypeEstimatedCategory, beds: Int?, bedType: String?) {
//        self.category = category
//        self.beds = beds
//        self.bedType = bedType
//    }
//}
//
//enum TypeEstimatedCategory {
//    case standardRoom
//    case studio
//    case superiorRoom
//}
//
//enum DatumType {
//    case hotelOffers
//}
//
//// MARK: - Meta
//class Meta {
//    let links: Links
//
//    init(links: Links) {
//        self.links = links
//    }
//}
//
//// MARK: - Links
//class Links {
//    let next: String
//
//    init(next: String) {
//        self.next = next
//    }
//}

