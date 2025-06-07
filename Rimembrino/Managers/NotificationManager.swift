//
//  File.swift
//  Rimembrino
//
//  Created by Vlad Gotovchykov on 18/10/24.
//

import Foundation
import NotificationCenter

class NotificationManager {
    
    static let shared = NotificationManager()
    let notificationSentences: [String] = [
        "Remember to bring your kit!",
        "Don't forget to take your items!",
        "You forgot to take your kit? Check the App!",
        "Did your take your kit?",
        "Maybe you forgot something? Check your kit!"
    ]

    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Permission granted for notifications")
            } else {
                print("Permission denied: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    func scheduleDailyNotifications() {
        let times = [
            (hour: 8, minute: 0),   // Morning Notification at 9 AM
            (hour: 13, minute: 0),  // Afternoon Notification at 1 PM
            (hour: 18, minute: 0)   // Evening Notification at 6 PM
        ]
        
        for (index, time) in times.enumerated() {
            let sentence = notificationSentences.randomElement() ?? "Stay positive!"
            scheduleNotification(atHour: time.hour, minute: time.minute, title: "Daily Reminder", body: sentence, identifier: "notification-\(index)")
        }
    }
    
    // Function to schedule a notification at a specific hour and minute
    private func scheduleNotification(atHour hour: Int, minute: Int, title: String, body: String, identifier: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
}
