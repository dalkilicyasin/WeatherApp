//
//  ForeCastResponseModel.swift
//  WeatherExample
//
//  Created by Yasin Dalkilic on 27.05.2022.
//

import Foundation
import ObjectMapper

struct ForeCastResponseModel : Mappable {
    var Headline : Headline?
    var DailyForecasts : [DailyForecasts]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        Headline <- map["Headline"]
        DailyForecasts <- map["DailyForecasts"]
    }

}

struct DailyForecasts : Mappable {
    var date : String?
    var epochDate : Int?
    var temperature : Temperature?
    var day : Day?
    var night : Night?
    var sources : [String]?
    var mobileLink : String?
    var link : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        date <- map["Date"]
        epochDate <- map["EpochDate"]
        temperature <- map["Temperature"]
        day <- map["Day"]
        night <- map["Night"]
        sources <- map["Sources"]
        mobileLink <- map["MobileLink"]
        link <- map["Link"]
    }

}

struct Day : Mappable {
    var icon : Int?
    var iconPhrase : String?
    var hasPrecipitation : Bool?
    var precipitationType : String?
    var precipitationIntensity : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        icon <- map["Icon"]
        iconPhrase <- map["IconPhrase"]
        hasPrecipitation <- map["HasPrecipitation"]
        precipitationType <- map["PrecipitationType"]
        precipitationIntensity <- map["PrecipitationIntensity"]
    }

}

struct Headline : Mappable {
    var effectiveDate : String?
    var effectiveEpochDate : Int?
    var severity : Int?
    var text : String?
    var category : String?
    var endDate : String?
    var endEpochDate : String?
    var mobileLink : String?
    var link : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        effectiveDate <- map["EffectiveDate"]
        effectiveEpochDate <- map["EffectiveEpochDate"]
        severity <- map["Severity"]
        text <- map["Text"]
        category <- map["Category"]
        endDate <- map["EndDate"]
        endEpochDate <- map["EndEpochDate"]
        mobileLink <- map["MobileLink"]
        link <- map["Link"]
    }

}


struct Maximum : Mappable {
    var value : Double?
    var unit : String?
    var unitType : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        value <- map["Value"]
        unit <- map["Unit"]
        unitType <- map["UnitType"]
    }

}

struct Minimum : Mappable {
    var value : Double?
    var unit : String?
    var unitType : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        value <- map["Value"]
        unit <- map["Unit"]
        unitType <- map["UnitType"]
    }

}

struct Night : Mappable {
    var icon : Int?
    var iconPhrase : String?
    var hasPrecipitation : Bool?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        icon <- map["Icon"]
        iconPhrase <- map["IconPhrase"]
        hasPrecipitation <- map["HasPrecipitation"]
    }

}

struct Temperature : Mappable {
    var minimum : Minimum?
    var maximum : Maximum?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        minimum <- map["Minimum"]
        maximum <- map["Maximum"]
    }

}
