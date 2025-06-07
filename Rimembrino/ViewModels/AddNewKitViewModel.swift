

import Foundation


import SwiftUI

class AddNewKitViewModel: ObservableObject {
    
    private var homeKit: HomeViewModel = HomeViewModel.shared
    
    @Published var kitModel: KitModel
    @Published var selectedImage: Image? = nil
    @Published var isImagePickerPresented = false
    @Published var selectedColor: Color = .gray {
        didSet {
            kitModel.color = ColorCodable(color: selectedColor)
        }
    }
    @Published var addToCalendar: Bool = false
    @Published var itemBeingEdited: KitItem? = nil
    @Published var editedName: String = ""
    @Published var editedDescription: String = ""
    @Published var showAlert: Bool = false
    @Published var isAddingNewItem: Bool = false
    
    init(kitModel: KitModel = KitModel()) {
        self.kitModel = kitModel
    }
    
    func addKits() {
        homeKit.kitList.append(kitModel)
        
    }
    
    
    func deleteItem(KitItem: KitItem) {
        if let index = kitModel.items.firstIndex(where: { $0.id == KitItem.id }) {
            kitModel.items.remove(at: index)
        }
    }
    
    func addItem() {
        if editedName.isEmpty {
            showAlert = true
        } else {
            if let itemBeingEdited = itemBeingEdited {
                // Edit existing item
                if let index = kitModel.items.firstIndex(where: { $0.id == itemBeingEdited.id }) {
                    kitModel.items[index].name = editedName
                    kitModel.items[index].description = editedDescription
                }
            } else {
                // Add new item
                let newItem = KitItem(name: editedName, description: editedDescription)
                kitModel.items.append(newItem)
            }
            // Reset form state
            resetItemForm()
        }
    }
    
    func resetItemForm() {
        isAddingNewItem = false
        editedName = ""
        editedDescription = ""
    }
}
