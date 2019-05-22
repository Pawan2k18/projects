//
//  JsonModel.swift
//  AlamofireWithSwiftyJSON
//
//  Created by Pawan Dey on 30/04/19.
//  Copyright © 2019 Kode. All rights reserved.
//

import Foundation
import SwiftyJSON

class DictData {
    var type = ""
    var id = ""

    var arrOffers = [DictOffers]()
    
    init(){
    }
    
    func setdata(dictJson: [String: JSON]) {
        type = dictJson["type"]?.stringValue ?? ""
        id = dictJson["id"]?.stringValue ?? ""
        
        for dictOffer in dictJson["offerItems"]!.arrayValue {
            let data = DictOffers()
            data.setdata(dictJson: dictOffer.dictionaryValue)
            self.arrOffers.append(data)
        }
    }
}


class DictOffers {
    var arrservices = [DictServices]()
    var price = Price()
    var pricePerAdult = PricePerAdult()
    init(){
    }
    
    func setdata(dictJson: [String: JSON]) {
        for dictServices in dictJson["services"]!.arrayValue {
            let data = DictServices()
            data.setdata(dictJson: dictServices.dictionaryValue)
            self.arrservices.append(data)
        }
        price.setdata(dictJson: dictJson["price"]?.dictionaryValue ?? [:])   // this line done by Harshad
        pricePerAdult.setdata(dictJson: dictJson["pricePerAdult"]?.dictionaryValue ?? [:])
    }
}

class DictServices{
    
    var arrsegments = [DictSegments]()
    
    init(){
    }
    func setdata(dictJson: [String: JSON]) {
        for dictSegments in dictJson["segments"]!.arrayValue {
            let data = DictSegments()
            data.setdata(dictJson: dictSegments.dictionaryValue)
            self.arrsegments.append(data)
        }
    }
}

class Price {
    var total = ""
    var totalTaxes = ""
    
    init(){
    }

    func setdata(dictJson: [String: JSON]) {
        total = dictJson["total"]?.stringValue ?? ""
        totalTaxes = dictJson["totalTaxes"]?.stringValue ?? ""
}
}

class PricePerAdult{
    var total = ""
    var totalTaxes = ""
    init(){
    }
    func setdata(dictJson: [String: JSON]) {
        total = dictJson["total"]?.stringValue ?? ""
        totalTaxes = dictJson["totalTaxes"]?.stringValue ?? ""
    }
}


class DictSegments {
    var flightSegment = FlightSegment()
    var pricingDetailPerAdult = PricingDetailPerAdult()
    
    init(){
    }
    func setdata(dictJson: [String: JSON]) {
        flightSegment.setdata(dictJson: dictJson["flightSegment"]?.dictionaryValue ?? [:])
        pricingDetailPerAdult.setdata(dictJson: dictJson["pricingDetailPerAdult"]?.dictionaryValue ?? [:])
    }
}

// PARSING VALUES OF FlightSegment
class FlightSegment{
    var carrierCode = ""
    var number = ""
    var duration = ""
    var departure = Departure()
    var arrival = Arrival()
    var aircraft = Aircraft()
    var operating = Operating()
    
    init(){
    }
    func setdata(dictJson: [String: JSON]) {
        carrierCode = dictJson["carrierCode"]?.stringValue ?? ""
        number = dictJson["number"]?.stringValue ?? ""
        duration = dictJson["duration"]?.stringValue ?? ""
        departure.setdata(dictJson: dictJson["departure"]?.dictionaryValue ?? [:])
        arrival.setdata(dictJson: dictJson["arrival"]?.dictionaryValue ?? [:])
    }
  
}

// PARSING VALUES OF PricingDetailPerAdult
class PricingDetailPerAdult{
    var travelClass = ""
    var fareClass = ""
    var availability = ""
    var fareBasis = ""
    
    init(){
    }
    func setdata(dictJson: [String: JSON]) {
        travelClass = dictJson["travelClass"]?.stringValue ?? ""
        fareClass = dictJson["fareClass"]?.stringValue ?? ""
        availability = dictJson["availability"]?.stringValue ?? ""
        fareBasis = dictJson["fareBasis"]?.stringValue ?? ""

    }
}


class Departure{
    var iataCode = ""
    var terminal = ""
    var at = ""
    
    init(){
    }
    func setdata(dictJson: [String: JSON]) {
        iataCode = dictJson["iataCode"]?.stringValue ?? ""
        terminal = dictJson["terminal"]?.stringValue ?? ""
        at = dictJson["at"]?.stringValue ?? ""

    }
}

class Arrival{
    var iataCode = ""
    var terminal = ""
    var at = ""
    
    init(){
    }
    func setdata(dictJson: [String: JSON]) {
        iataCode = dictJson["iataCode"]?.stringValue ?? ""
        terminal = dictJson["terminal"]?.stringValue ?? ""
        at = dictJson["at"]?.stringValue ?? ""
        
    }
}

class Aircraft{
    var code = ""
    init(){
    }
    func setdata(dictJson: [String: JSON]) {
        code = dictJson["code"]?.stringValue ?? ""
        
    }
}

class Operating{
    var duration = ""
    init(){
    }
    func setdata(dictJson: [String: JSON]) {
        duration = dictJson["duration"]?.stringValue ?? ""
        
    }
}
