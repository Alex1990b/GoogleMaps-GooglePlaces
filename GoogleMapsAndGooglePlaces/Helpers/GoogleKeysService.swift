//
//  GoogleKeysService.swift
//  TeamvoyTestApp
//
//  Created by Alex on 04.12.18.
//  Copyright © 2018 alex. All rights reserved.
//

import GoogleMaps
import GooglePlaces

struct GoogleKeysService {
    
    static func configure() {
        GMSServices.provideAPIKey("AIzaSyBYDB9ATN2p1GoUc53Vz_rMW7t9jj6QB9k")
        GMSPlacesClient.provideAPIKey("AIzaSyBYDB9ATN2p1GoUc53Vz_rMW7t9jj6QB9k")
    }
}
