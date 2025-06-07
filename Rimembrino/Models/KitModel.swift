//
//  KitModel.swift
//  Rimembrino
//
//  Created by Vlad Gotovchykov on 11/10/24.
//

import Foundation
import SwiftUICore
import UIKit
import SwiftData


class KitModel: Identifiable, Codable, Equatable {
    
    
    var id: UUID = UUID()
    var kitName: String = ""
    //@State private var addHome: Bool = false
    var selectedDate = Date()
    var selectedTime = Date()
    var items: [KitItem] = [] // List of items in the kit
    var color: ColorCodable = ColorCodable(color: .red)
//    var color: Color = Color.red
    //var selectedImage: Image? = nil
    //var isImagePickerPresented = false   // State to toggle image picker presentation
    
    static func == (lhs: KitModel, rhs: KitModel) -> Bool {
        lhs.id == rhs.id
    }
    
    
}

// Item model representing the data structure for each item\

struct KitItem: Identifiable, Codable {
    var id: UUID = UUID()         // Unique identifier for each item
    var name: String          // Name of the item
    var description: String   // Description of the item
    var isSelected: Bool = false
}


struct ColorCodable: Codable {
    let red: Double
    let green: Double
    let blue: Double
    let opacity: Double

    init(color: Color) {
        let uiColor = UIColor(color)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        self.red = Double(red)
        self.green = Double(green)
        self.blue = Double(blue)
        self.opacity = Double(alpha)
    }

    func toColor() -> Color {
        return Color(red: red, green: green, blue: blue, opacity: opacity)
    }
}
