//
//  LocationManager.swift
//  Rimembrino
//
//  Created by Vlad Gotovchykov on 25/11/24.
//

import Foundation
import CoreLocation
import SwiftUI
import MapKit



final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion()
    
    static var shared: LocationManager = .init()
    
    var locationManager: CLLocationManager?
    var location: CLLocation?
    var errorMessage: String?
    
    override init() {
        super.init()
        checkLocationAuthorization()
    }
    
    func ifLocationServicesEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
        } else {
            errorMessage = "Please enable location services in Settings."
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
                self.errorMessage = "You won't be able to use all the features of the app."
        case .authorizedAlways, .authorizedWhenInUse:
            if let currentLocation = locationManager.location {
                    self.region = MKCoordinateRegion(
                        center: currentLocation.coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                    )
                //print(region)
            }
        default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
        //print(region)
    }
    
    func locateMyLocation(region: MKCoordinateRegion) {
        return self.region = region
    }
}
