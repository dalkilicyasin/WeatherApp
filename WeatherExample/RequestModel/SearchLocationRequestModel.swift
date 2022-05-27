//
//  SearchLocationRequestModel.swift
//  WeatherExample
//
//  Created by Yasin Dalkilic on 27.05.2022.
//

import Foundation
import UIKit
import ObjectMapper

public class  SearchLocationRequestModel : Mappable{
    
  var searchText = ""
    
    public required init?(map: Map) {
        
    }
    
    public init (searchText : String){
        self.searchText = searchText
    }

    
    public func mapping(map: Map) {
    }
    
    public func requestPathString()->String{
        // 2. parametre eklemek için & işareti koy
        return "?apikey=\(BaseData.shared.apiKey)&q=\(self.searchText)"
    }
    
}
