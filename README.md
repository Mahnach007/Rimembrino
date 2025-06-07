# Rimembrino - Smart Kit Management App

## Overview
Rimembrino is an iOS application built with SwiftUI that helps users manage and remember their essential kits and items. The app combines kit management with location-based reminders and features an intuitive interface with delightful animations.

## Demo Photo

![image](https://github.com/user-attachments/assets/11c5906a-5dee-4eff-be43-ab7167690f1f)


## Features

### 1. Kit Management
- Create and manage multiple kits with customizable names and colors
- Add/edit/delete items within each kit
- Checklist functionality for items in kits
- Pin important kits to the top of the list
- Detailed item descriptions and status tracking

### 2. Location Services
- Map integration with user location tracking
- Location-based reminders for kits
- Interactive map view with custom pin placement

### 3. Smart Notifications
- Scheduled daily reminders at key times (8 AM, 1 PM, 6 PM)
- Customizable notification messages
- Location-based notifications when leaving marked places

### 4. User Interface
- Modern SwiftUI interface with tab-based navigation
- Custom animations using Lottie
- Interactive map view
- Intuitive item management with swipe actions
- Color customization for kits

## Technical Details

### Architecture
- Built with SwiftUI and Swift
- MVVM (Model-View-ViewModel) architecture
- Uses SwiftData for data persistence
- Implements CoreLocation for location services
- Utilizes UserDefaults for kit storage

### Key Components
- `HomeViewModel`: Manages the main kit list and persistence
- `LocationManager`: Handles location services and authorization
- `NotificationManager`: Manages scheduled notifications and permissions
- `MapViewModel`: Controls map interactions and location tracking

### Dependencies
- Lottie: For custom animations
- SwiftUI
- MapKit
- CoreLocation
- SwiftData

## Requirements
- iOS 18.0+
- Xcode 15.0+
- Swift 5.0+

## Installation
1. Clone the repository
2. Open `Rimembrino.xcodeproj` in Xcode
3. Build and run the project

## Permissions Required
- Location Services (When In Use/Always)
- Notification Permissions

## License and Commercial Use

### Personal Use
This project is free for personal and educational use.

### Commercial Use
For commercial use, you must obtain a commercial license. Please contact us before using Rimembrino in any commercial project or application.

To obtain a commercial license, contact:
- Email: vlad.gotovchykov@gmail.com

  
**Important Notice:**
- Any commercial use without proper licensing is strictly prohibited
- Modifications and derivatives must maintain these license terms
- The software is provided "as is" without warranty of any kind

## Future Enhancements
1. Calendar integration for kit scheduling
2. Cloud sync capabilities
3. Sharing kits between users
4. Advanced reminder settings
5. Custom categories and tags for kits

## Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

---
© [Current Year] Rimembrino. All Rights Reserved.
