//
//  ViewController.swift
//  TeamvoyTestApp
//
//  Created by Alex on 04.12.18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

final class MapViewController: UIViewController {
    
    //MARK: @IBOutlets
    
    @IBOutlet private weak var selectLocationTextField: UITextField!
    @IBOutlet private weak var mapConteinerView: UIView!
    
    //MARK: Constants
    
    private let googleMapsHelper = GoogleMapsHelper()
    private let autocompliteService = AutocompliteService()
    
    //MARK: MapViewController Lify Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        googleMapsHelper.addMap(on: mapConteinerView)
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

//MARK: UITextFieldDelegate

extension MapViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        present(autocompliteService.autocompleteViewController, animated: true, completion: nil)
    }
}

//MARK: AutoComplitable

extension MapViewController: AutoComplitable {
    func wasCancelled() {
        selectLocationTextField.text = ""
        dismiss(animated: true, completion: nil)
    }
    
    func didAutocomplete(with place: Place) {
        selectLocationTextField.text = place.name
        dismiss(animated: true) {
            self.googleMapsHelper.showMarker(at: place)
            self.googleMapsHelper.animate(to: place)
        }
    }
}

//MARK: Private Methods

private extension MapViewController {
    func listenGoogleMapsHelperCallback() {
        googleMapsHelper.infoWindowDidTapped = { [weak self] place in
            guard let strSelf = self else { return }
            let vc: SunriseAndSunsetViewController = strSelf.storyboard!.instantiateViewController()
            vc.place = place
            strSelf.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

