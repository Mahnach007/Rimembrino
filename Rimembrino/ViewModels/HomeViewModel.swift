import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var kitList: [KitModel] = []
    
    static let shared = HomeViewModel()

    init() {
        loadKits()
    }
    
    // Deletes a kit
    func deleteKitView(kit: KitModel) {
        kitList.removeAll(where: { $0.id == kit.id })
        saveKits()
    }
    
    // Saves the kits to UserDefaults
    func saveKits() {
        if let encodedData = try? JSONEncoder().encode(kitList) {
            UserDefaults.standard.set(encodedData, forKey: "savedKits")
            print(encodedData)
        }
        
    }
    
    func pinOnTop(kit: KitModel) {
        
        if let index = kitList.firstIndex(of: kit) {
                kitList.remove(at: index)
            }
            
            // Insert the kit at the top of the list
            kitList.insert(kit, at: 0)
            
            // Save the updated list
            saveKits()
    }
    
    // Loads the kits from UserDefaults
    func loadKits() {
        if let savedData = UserDefaults.standard.data(forKey: "savedKits"),
           let decodedData = try? JSONDecoder().decode([KitModel].self, from: savedData) {
            kitList = decodedData
        }
    }
}
