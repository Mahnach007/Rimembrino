//
//  MapView.swift
//  Rimembrino
//
//  Created by Vlad Gotovchykov on 13/11/24.
//

import SwiftUI
import MapKit


struct MapView: View {
    
    @EnvironmentObject private var viewModel: MapViewModel
    
    @State var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 31.2, longitude: 21.3), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    var body: some View {
        
        ZStack {
            
            Button {
                viewModel.locateMyLocation()
            } label: {
                Text(Image(systemName: "pin"))
            }

            
            Map(
                coordinateRegion: $viewModel.region,
                interactionModes: .all,
                showsUserLocation: true
            )
            .ignoresSafeArea(edges: .top)
            .onAppear {
                viewModel.locationManager.ifLocationServicesEnabled()
                viewModel.showLocationServicesEnabled()
                //print(viewModel.locationManager.region)
            }
            
        }
    }
}

#Preview {
    MapView()
}
