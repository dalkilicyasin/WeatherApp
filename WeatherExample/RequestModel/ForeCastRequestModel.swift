//
//  ForeCastRequestModel.swift
//  WeatherExample
//
//  Created by Yasin Dalkilic on 27.05.2022.
//

import Foundation
import UIKit
import ObjectMapper

public class  ForeCastRequestModel : Mappable{
    
  var cityCode = ""
    
    public required init?(map: Map) {
        
    }
    
    public init (cityCode : String){
        self.cityCode = cityCode
    }

    
    public func mapping(map: Map) {
    }
    
    public func requestPathString()->String{
        // 2. parametre eklemek için & işareti koy
        return "/\(self.cityCode)?apikey=\(BaseData.shared.apiKey)"
    }
    
}
