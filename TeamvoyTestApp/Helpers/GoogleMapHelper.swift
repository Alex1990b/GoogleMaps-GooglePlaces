//
//  GoogleMapHelper.swift
//  MingleGo
//
//  Created by User on 27.12.17.
//  Copyright © 2017 inVeritaSoft. All rights reserved.
//

import GoogleMaps

final class GoogleMapsHelper: NSObject {
    
    //MARK: Constants
    
    private let locationHelper = LocationHelper()
    
    //MARK: Variables
    
    private var mapView: GMSMapView!
    private var currentMarker: GMSMarker?
    private var currentPlace: Place?
    private var isMyLocationTapped = false
   
    var infoWindowDidTapped: ((_ place: Place?) -> ())?
    
    //MARK: Public methods
        
    func addMap(on view: UIView) {
      
        mapView = GMSMapView(frame: CGRect(origin: CGPoint.zero,
                                           size: view.frame.size))
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        mapView.mapType = .normal
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.delegate = self
        locationHelper.delegate = self
        view.addSubview(mapView)
    }
    
    func animate(to place: Place, zoom: Float = 12) {
        
        currentMarker = nil
        
        let  startedCameraPosition = GMSCameraPosition.camera(withLatitude: mapView.camera.target.latitude,
                                                              longitude: mapView.camera.target.longitude,
                                                              zoom: mapView.minZoom)
        let  finalCameraPosition = GMSCameraPosition.camera(withLatitude: place.latitude,
                                                            longitude: place.longitude,
                                                            zoom: zoom)
        
        mapView.camera = startedCameraPosition
        
        CATransaction.begin()
        CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
        mapView.animate(to: finalCameraPosition)
        CATransaction.commit()
    }
    
    func showMarker(at place: Place) {
        currentPlace = place
        addMarker(latitude: place.latitude, longitude: place.longitude)
    }
}

//MARK: LocationUpdateDelegate

extension GoogleMapsHelper: LocationUpdateDelegate {
    func locationDidUpdate(with newPlace: Place) {
        if isMyLocationTapped {
            currentPlace = newPlace
            currentMarker?.position = CLLocationCoordinate2D(latitude: newPlace.latitude,
                                                             longitude: newPlace.longitude)
        }
    }
}

//MARK: GMSMapViewDelegate

extension GoogleMapsHelper: GMSMapViewDelegate {
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        addMarker(latitude: locationHelper.myLocation?.coordinate.latitude ?? 0,
                  longitude: locationHelper.myLocation?.coordinate.longitude ?? 0)
        isMyLocationTapped = true
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        currentMarker = marker
        return false
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let infoWindow = MapInfoWindowView.instanceFromNib() as! MapInfoWindowView
        infoWindow.place = currentPlace
        
        return infoWindow
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        infoWindowDidTapped?(currentPlace)
    }
}

//MARK: Private methods

private extension GoogleMapsHelper {
    func addMarker(latitude: Double, longitude: Double ) {
        isMyLocationTapped = false
        mapView.clear()
        currentMarker = GMSMarker()
        currentMarker?.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        currentMarker?.map = mapView
    }
}



