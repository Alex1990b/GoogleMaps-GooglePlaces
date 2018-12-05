//
//  AutocompliteService.swift
//  TeamvoyTestApp
//
//  Created by Alex on 04.12.18.
//  Copyright © 2018 alex. All rights reserved.
//

import GooglePlaces

protocol Autocomplitable: class  {
    func didAutocompleteWith(place: Place)
    func wasCancelled()
}

final class AutocompliteService: NSObject {
    
    private(set) var atocompleteViewController = GMSAutocompleteViewController()
    
    weak var delegate: (Autocomplitable & AlertDisplayable)?
    
    override init() {
        super.init()
        atocompleteViewController.delegate = self
    }
}

extension AutocompliteService: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        delegate?.showAlert(with: error)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let place = Place(adress: place.formattedAddress ?? "", name: place.name, latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        delegate?.didAutocompleteWith(place: place)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        delegate?.wasCancelled()
    }
}
