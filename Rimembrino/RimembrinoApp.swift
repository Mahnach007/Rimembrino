//
//  RimembrinoApp.swift
//  Rimembrino
//
//  Created by Vlad Gotovchykov on 07/10/24.
//

import SwiftUI
import SwiftData

@main
struct RimembrinoApp: App {
    init() {
            // Request notification permission and schedule notifications
            NotificationManager.shared.requestPermission()
            NotificationManager.shared.scheduleDailyNotifications()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environmentObject(MapViewModel())
        .modelContainer(for: MapPointModel.self)
    }
}
