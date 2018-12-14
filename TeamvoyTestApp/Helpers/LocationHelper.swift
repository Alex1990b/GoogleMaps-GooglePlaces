//
//  LocationHelper.swift
//  Tourburst
//
//  Created by Mykhailo Melnychuk on 11.04.18.
//  Copyright © 2018 inVeritaSoft. All rights reserved.
//

import CoreLocation

protocol LocationUpdateDelegate: class {
    func locationDidUpdate(with: Place)
}

final class LocationHelper: NSObject {
    
    //MARK: Constants
    
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    //MARK: Variables
    
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

 //MARK: CLLocationManagerDelegate

extension LocationHelper: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let lastLocation = locations.last else { return }
        geocoder.reverseGeocodeLocation(lastLocation, completionHandler: { [weak self] placemarks, error  in
            if let placemarks = placemarks, let lastPlacemark = placemarks.last {
                let place = Place(address: lastPlacemark.administrativeArea ?? "", name: lastPlacemark.locality ?? "", latitude: lastPlacemark.location?.coordinate.latitude ?? 0, longitude: lastPlacemark.location?.coordinate.longitude ?? 0)
                self?.delegate?.locationDidUpdate(with: place)
            }
        })
    }
}
