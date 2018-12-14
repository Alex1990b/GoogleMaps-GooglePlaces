//
//  AutocompliteService.swift
//  TeamvoyTestApp
//
//  Created by Alex on 04.12.18.
//  Copyright © 2018 alex. All rights reserved.
//

import GooglePlaces

protocol AutoComplitable: class  {
    func didAutocomplete(with place: Place)
    func wasCancelled()
}

final class AutocompliteService: NSObject {
    
    //MARK: Variables
    
    private(set) var autocompleteViewController = GMSAutocompleteViewController()
    
    weak var delegate: (AutoComplitable & AlertDisplayable)?
    
    override init() {
        super.init()
        autocompleteViewController.delegate = self
    }
}

//MARK: GMSAutocompleteViewControllerDelegate

extension AutocompliteService: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        delegate?.showAlert(with: error)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let place = Place(address: place.formattedAddress ?? "",
                          name: place.name,
                          latitude: place.coordinate.latitude,
                          longitude: place.coordinate.longitude)
        delegate?.didAutocomplete(with: place)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        delegate?.wasCancelled()
    }
}
