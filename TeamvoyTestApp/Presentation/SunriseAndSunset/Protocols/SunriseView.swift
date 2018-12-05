//
//  SunriseView.swift
//  TeamvoyTestApp
//
//  Created by Alex on 04.12.18.
//  Copyright © 2018 alex. All rights reserved.
//

import Foundation

protocol SunriseView: class {
    func update(with data: SunriseSunsetResponse.SunriseSunset)
}
