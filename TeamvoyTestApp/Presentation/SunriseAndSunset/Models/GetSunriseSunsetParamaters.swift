//
//  GetSunriseSunsetParamaters.swift
//  TeamvoyTestApp
//
//  Created by Alex on 04.12.18.
//  Copyright © 2018 alex. All rights reserved.
//

import Foundation

struct GetSunriseSunsetParamaters: ApiParametersProtocol {
    func convertToDictionary() -> [String : Any] {
        return ["lat": latitude, "lng": longitude]
    }
    
    let latitude: Double
    let longitude: Double
}
