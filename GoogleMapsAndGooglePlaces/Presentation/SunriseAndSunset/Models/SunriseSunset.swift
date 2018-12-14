//
//  SunriseSunset.swift
//  TeamvoyTestApp
//
//  Created by Alex on 05.12.18.
//  Copyright © 2018 alex. All rights reserved.
//

import Foundation

struct SunriseSunsetResponse: Decodable {
    
    let results: SunriseSunset?
    let status: String?
    
    struct SunriseSunset: Decodable {
        let sunrise: String?
        let sunset : String?
        let solarNoon: String?
        let dayLength: String?
        let civilTwilightBegin: String?
        let civilTwilightEnd: String?
        let nauticalTwilightBegin: String?
        let nauticalTwilightEnd: String?
        let astronomicalTwilightBegin: String?
        let astronomicalTwilightEnd: String?
    }
}
