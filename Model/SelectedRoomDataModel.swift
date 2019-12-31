//
//  SelectedRoomDataModel.swift
//  Travanada2
//
//  Created by Pawan Dey on 30/08/19.
//  Copyright © 2019 nibble. All rights reserved.
//


import Foundation
import SwiftyJSON

//class SelectedRoomDataModel2 {
//    var data2 = SelectedRoomDataModel()
//
//    init() {
//    }
//
//    func setdata(dictJson: JSON) {
//        data2.setdata(dictJson: dictJson["data"].dictionaryValue)
//    }
//}


class SelectedRoomDataModel {

    var type =  ""
    var hotel2 = Hotel2()
    var available = ""
    var arroffers = [Offer]()

    init() {

    }

    func setdata(dictJson: JSON) {
        type = dictJson["type"].stringValue
        available = dictJson["available"].stringValue

        hotel2.setdata(dictJson: dictJson["hotel"].dictionaryValue)

        for dictOffer in dictJson["offers"].arrayValue {
            let data = Offer()
            data.setdata(dictJson: dictOffer.dictionaryValue)
            self.arroffers.append(data)
        }
       
        
    }
}

// MARK: - Hotel
class Hotel2 {
    var type = ""
    var hotelID = ""
    var chainCode = ""
    var dupeID = ""
    var name = ""
    var rating = ""
    var cityCode = ""
    var latitude = ""
    var longitude = ""
    var address = Address2()
    var contact = Contact2()
    //var amenities = [Amenities]()
    //var media = [Media2]()?

    init() {

    }
    func setdata(dictJson: [String: JSON]){
        type = dictJson["type"]?.stringValue ?? ""
        hotelID = dictJson["hotelId"]?.stringValue ?? ""
        chainCode = dictJson["chainCode"]?.stringValue ?? ""
        dupeID = dictJson["dupeID"]?.stringValue ?? ""
        name = dictJson["name"]?.stringValue ?? ""
        rating = dictJson["rating"]?.stringValue ?? ""
        cityCode = dictJson["cityCode"]?.stringValue ?? ""
        latitude = dictJson["latitude"]?.stringValue ?? ""
        longitude = dictJson["longitude"]?.stringValue ?? ""

         address.setdata(dictJson: dictJson["address"]?.dictionaryValue ?? [:])
         contact.setdata(dictJson: dictJson["contact"]?.dictionaryValue ?? [:])
        
//        for dictMedia in dictJson["media"]!.arrayValue {
//            let data = Media2()
//            data.setdata(dictJson: dictMedia.dictionaryValue)
//            self.media.append(data)
//        }
        
//        for dictAmen in dictJson["amenities"]!.arrayValue {
//            let data = Amenities()
//            data.setdata(dictJson: dictAmen.dictionaryValue)
//            self.amenities.append(data)
//        }
    }
}

//class Media2 {
//    var uri = ""
//    var category = ""
//
//    init() {
//    }
//
//    func setdata(dictJson: [String: JSON]) {
//        uri = dictJson["uri"]?.stringValue ?? ""
//        category = dictJson["category"]?.stringValue ?? ""
//    }
//}


//class Amenities {
//    init() {
//    }
//
//    func setdata(dictJson: [String: JSON]) {
//    }
//}




// MARK: - Address
class Address2 {
//    var lines: []
    var postalCode = ""
    var cityName = ""
    var countryCode =  ""

    init() {

    }

    func setdata(dictJson: [String: JSON]){
        postalCode = dictJson["postalCode"]?.stringValue ?? ""
        cityName = dictJson["cityName"]?.stringValue ?? ""
        countryCode = dictJson["countryCode"]?.stringValue ?? ""
    }
}

// MARK: - Contact
class Contact2 {
    var phone = ""
    var fax =  ""

    init() {
    }

    func setdata(dictJson: [String: JSON]){
        phone = dictJson["phone"]?.stringValue ?? ""
        fax = dictJson["fax"]?.stringValue ?? ""

    }
}



// MARK: - Offer
class Offer {
    var id = ""
    var rateCode = ""
    var rateFamilyEstimated = ""
    var room = Room()
    var guests = Guests()
    var price = Price3()
    //var offerSelf =  ""

    init() {

    }

     func setdata(dictJson: [String: JSON]) {
        id = dictJson["id"]?.stringValue ?? ""
        rateCode = dictJson["rateCode"]?.stringValue ?? ""

        room.setdata(dictJson: dictJson["room"]?.dictionaryValue ?? [:])
        guests.setdata(dictJson: dictJson["guests"]?.dictionaryValue ?? [:])
        price.setdata(dictJson: dictJson["price"]?.dictionaryValue ?? [:])
    }
}

// MARK: - Guests
class Guests {
    var adults = ""

    init() {

    }
    func setdata(dictJson: [String: JSON]) {
        adults = dictJson["adults"]?.stringValue ?? ""
    }
}

// MARK: - Price
class Price3 {
    var currency = ""
    var total =  ""

    init() {
    }
    func setdata(dictJson: [String: JSON]) {
        currency = dictJson["currency"]?.stringValue ?? ""
        total = dictJson["total"]?.stringValue ?? ""
    }
}

// MARK: - RateFamilyEstimated
class RateFamilyEstimated {
    var code = ""
    var type = ""

    init() {
    }
    func setdata(dictJson: [String: JSON]) {
        code = dictJson["code"]?.stringValue ?? ""
        type = dictJson["type"]?.stringValue ?? ""
    }

}

// MARK: - Room
class Room {
    var type =  ""
    var typeEstimated = TypeEstimated()
    var roomDescription = Description3()

    init() {

    }
    func setdata(dictJson: [String: JSON]) {
        type = dictJson["type"]?.stringValue ?? ""

        typeEstimated.setdata(dictJson: dictJson["typeEstimated"]?.dictionaryValue ?? [:])
        roomDescription.setdata(dictJson: dictJson["description"]?.dictionaryValue ?? [:])
    }

}

// MARK: - Description
class Description3 {
    var lang = ""
    var text = ""

    init() {
    }
    func setdata(dictJson: [String: JSON]) {
        lang = dictJson["lang"]?.stringValue ?? ""
        text = dictJson["text"]?.stringValue ?? ""
    }

}

// MARK: - TypeEstimated
class TypeEstimated {
    var category =  ""
    var beds = ""
    var bedType = ""

    init() {
    }
    func setdata(dictJson: [String: JSON]) {
        category = dictJson["category"]?.stringValue ?? ""
        beds = dictJson["beds"]?.stringValue ?? ""
        bedType = dictJson["bedType"]?.stringValue ?? ""
    }
}
