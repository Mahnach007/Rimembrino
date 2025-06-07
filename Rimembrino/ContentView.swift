//
//  ContentView.swift
//  Rimembrino
//
//  Created by Vlad Gotovchykov on 07/10/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    var body: some View {
        
        TabView {
            HomeView().tabItem {
                Label("Kits", systemImage: "list.dash")
            }
            MapView().tabItem {
                Label("Map", systemImage: "map")
            }
        }.toolbarBackground(.black, for: .tabBar)
            
        }
    }

#Preview {
    ContentView().environmentObject(MapViewModel())
}
