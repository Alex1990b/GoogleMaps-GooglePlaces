//
//  LocationHelper.swift
//  Tourburst
//
//  Created by Mykhailo Melnychuk on 11.04.18.
//  Copyright © 2018 inVeritaSoft. All rights reserved.
//

import CoreLocation

protocol LocationUpdateDelegate: class {
    func locationDidUpdate(newPlace: Place)
}

final class LocationHelper: NSObject {
    
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    var myLocation: CLLocation? {
        return locationManager.location
    }
    
    weak var delegate: LocationUpdateDelegate?
        
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
}

extension LocationHelper: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let lastLocation = locations.last else { return }
        geocoder.reverseGeocodeLocation(lastLocation, completionHandler: { [weak self] placemarks, error  in
            if let placemarks = placemarks, let lastPlacemark = placemarks.last {
                let place = Place(adress: lastPlacemark.administrativeArea ?? "", name: lastPlacemark.locality ?? "", latitude: lastPlacemark.location?.coordinate.latitude ?? 0, longitude: lastPlacemark.location?.coordinate.longitude ?? 0)
                self?.delegate?.locationDidUpdate(newPlace: place)
            }
        })
    }
}
