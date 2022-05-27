//
//  ServiceEndPoint.swift
//  BaseProject
//
//  Created by Cüneyt AYVAZ on 2.07.2019.
//  Copyright © 2019 OtiHolding. All rights reserved.
//

import Foundation

public enum ServiceEndPoint: String {
    case TopCitiyList = "/locations/v1/topcities/150"
    case ForeCast = "/forecasts/v1/daily/5day"
    case SearchCitys = "/locations/v1/cities/search"
}
