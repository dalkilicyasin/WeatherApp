//
//  TopCitysRequestModel.swift
//  InstaClone
//
//  Created by Yasin Dalkilic on 26.05.2022.
//

import Foundation
import UIKit
import ObjectMapper

public class  TopCitysRequestModel : Mappable{
    
  
    
    public required init?(map: Map) {
        
    }
    
    public init (){
  
    }

    
    public func mapping(map: Map) {
    }
    
    public func requestPathString()->String{
        // 2. parametre eklemek için & işareti koy
        return "?apikey=\(BaseData.shared.apiKey)"
    }
    
}
