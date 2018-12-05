//
//  SunrisePresenter.swift
//  TeamvoyTestApp
//
//  Created by Alex on 05.12.18.
//  Copyright © 2018 alex. All rights reserved.
//

import Foundation


final class SunrisePresenter {
    
    private let newtworkService = SunriseSunsetNetworkService()
    
    weak var delegate: (SunriseView & AlertDisplayable)?
    
    func fetchSunriceFor(place: Place) {
        let parameters = GetSunriseSunsetParamaters(latitude: place.latitude, longitude: place.longitude)
        newtworkService.fetchSunriseSunset(parameters: parameters) { [weak self] (response, error) in
            if let error = error {
                self?.delegate?.showAlert(with: error)
            }
            
            if let result = response?.results {
                self?.delegate?.update(with: result)
            }
        }
    }
}
