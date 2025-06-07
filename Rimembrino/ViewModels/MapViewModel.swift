//
//  MapViewModel.swift
//  Rimembrino
//
//  Created by Vlad Gotovchykov on 18/11/24.
//

import Foundation
import MapKit
import SwiftUI

class MapViewModel: ObservableObject {
    
    @Published var locations: [MapPointModel] = []
    @Published var region: MKCoordinateRegion = MKCoordinateRegion()
    
    @ObservedObject var locationManager = LocationManager.shared
        
    init() {
        locationManager.$region.assign(to: &$region)
    }
    
    func showLocationServicesEnabled() {
        print(locationManager.region)
        locationManager.ifLocationServicesEnabled()
    }
    
    func locateMyLocation() {
        locationManager.locateMyLocation(region: region)
    }
    
}
