//
//  ViewController.swift
//  TeamvoyTestApp
//
//  Created by Alex on 04.12.18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

final class MapViewController: UIViewController {
    
    @IBOutlet private weak var selectLocationTextField: UITextField!
    @IBOutlet private weak var mapConteinerView: UIView!
    
    private let googleMapsHelper = GoogleMapsHelper()
    private let autocompliteService = AutocompliteService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        googleMapsHelper.addMapView(on: mapConteinerView)
        listenGoogleMapsHelperCallback()
        autocompliteService.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        selectLocationTextField.layer.cornerRadius = selectLocationTextField.frame.height / 2
        selectLocationTextField.setBorders(color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), width: 2)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension MapViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        present(autocompliteService.atocompleteViewController, animated: true, completion: nil)
    }
}

extension MapViewController: Autocomplitable {
    func didAutocompleteWith(place: Place) {
        selectLocationTextField.text = place.name
        dismiss(animated: true) {
            self.googleMapsHelper.showPlaceMarker(place)
            self.googleMapsHelper.animateToLocation(place: place)
        }
    }
    
    func wasCancelled() {
        selectLocationTextField.text = ""
        dismiss(animated: true, completion: nil)
    }
}

private extension MapViewController {
    func listenGoogleMapsHelperCallback() {
        googleMapsHelper.infoWindowDidTapped = { [weak self] place in
            guard let strSelf = self else { return }
            let sunriseAndSunsetViewController: SunriseAndSunsetViewController = strSelf.storyboard!.instantiateViewController()
            sunriseAndSunsetViewController.place = place
            strSelf.navigationController?.pushViewController(sunriseAndSunsetViewController, animated: true)
        }
    }
}

