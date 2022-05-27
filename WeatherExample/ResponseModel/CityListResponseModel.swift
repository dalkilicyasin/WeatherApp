//
//  CityListResponseModel.swift
//  InstaClone
//
//  Created by Yasin Dalkilic on 26.05.2022.
//

import Foundation
import ObjectMapper

struct AdministrativeArea : Mappable {
    var id : String?
    var localizedName : String?
    var englishName : String?
    var level : Int?
    var localizedType : String?
    var englishType : String?
    var countryID : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        localizedName <- map["LocalizedName"]
        englishName <- map["EnglishName"]
        level <- map["Level"]
        localizedType <- map["LocalizedType"]
        englishType <- map["EnglishType"]
        countryID <- map["CountryID"]
    }

}

struct Country : Mappable {
    var iD : String?
    var localizedName : String?
    var englishName : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        iD <- map["ID"]
        localizedName <- map["LocalizedName"]
        englishName <- map["EnglishName"]
    }

}

struct Elevation : Mappable {
    var metric : Metric?
    var imperial : Imperial?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        metric <- map["Metric"]
        imperial <- map["Imperial"]
    }

}


struct GeoPosition : Mappable {
    var latitude : Double?
    var longitude : Double?
    var elevation : Elevation?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        latitude <- map["Latitude"]
        longitude <- map["Longitude"]
        elevation <- map["Elevation"]
    }

}


struct Imperial : Mappable {
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

struct CityListResponseModel : Mappable {
    var version : Int?
    var Key : String?
    var type : String?
    var rank : Int?
    var localizedName : String?
    var englishName : String?
    var primaryPostalCode : String?
    var region : Region?
    var country : Country?
    var administrativeArea : AdministrativeArea?
    var timeZone : TimeZone?
    var geoPosition : GeoPosition?
    var isAlias : Bool?
    var supplementalAdminAreas : [String]?
    var dataSets : [String]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        version <- map["Version"]
        Key <- map["Key"]
        type <- map["Type"]
        rank <- map["Rank"]
        localizedName <- map["LocalizedName"]
        englishName <- map["EnglishName"]
        primaryPostalCode <- map["PrimaryPostalCode"]
        region <- map["Region"]
        country <- map["Country"]
        administrativeArea <- map["AdministrativeArea"]
        timeZone <- map["TimeZone"]
        geoPosition <- map["GeoPosition"]
        isAlias <- map["IsAlias"]
        supplementalAdminAreas <- map["SupplementalAdminAreas"]
        dataSets <- map["DataSets"]
    }

}


struct Metric : Mappable {
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

struct Region : Mappable {
    var iD : String?
    var localizedName : String?
    var englishName : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        iD <- map["ID"]
        localizedName <- map["LocalizedName"]
        englishName <- map["EnglishName"]
    }

}

struct TimeZone : Mappable {
    var code : String?
    var name : String?
    var gmtOffset : Double?
    var isDaylightSaving : Bool?
    var nextOffsetChange : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        code <- map["Code"]
        name <- map["Name"]
        gmtOffset <- map["GmtOffset"]
        isDaylightSaving <- map["IsDaylightSaving"]
        nextOffsetChange <- map["NextOffsetChange"]
    }

}

