import Foundation

class KitItemListViewModel: ObservableObject {
    
    @Published var kit: KitModel
    @Published var items: [KitItem] = []
    @Published var editingItemId: UUID? // Tracks the item currently being edited
    
    
    
    
    init(kit: KitModel) {
        self.kit = kit
    }

    // Update an item with new title and subtitle
    func updateItem(item: KitItem, newTitle: String, newDescription: String) {
        if let index = kit.items.firstIndex(where: { $0.id == item.id }) {
            kit.items[index].name = newTitle
            kit.items[index].description = newDescription
        }
    }

    // Toggle checklist status for an item
    func toggleChecklist(item: KitItem) {
        if let index = kit.items.firstIndex(where:  { $0.id == item.id }) {
            kit.items[index].isSelected.toggle()
//            kit.items.remove(at: index)
//            var newItem = item
//            newItem.isSelected.toggle()
//            kit.items.insert(newItem, at: index)
//            kit.items = kit.items.reversed()
        }
        HomeViewModel.shared.saveKits()
        HomeViewModel.shared.loadKits()
    }

    // Delete an item from the list
    func deleteItem(item: KitItem) {
        kit.items.removeAll { $0.id == item.id }
        print(kit.items)
        HomeViewModel.shared.saveKits()
    }
    
    // Add a new item to the list
    func addItem(title: String, subtitle: String) {
        let newItem = KitItem(name: title, description: subtitle)
        kit.items.append(newItem)
        HomeViewModel.shared.saveKits()
    }
    
    // Start editing mode for an item
    func startEditing(itemId: UUID) {
        editingItemId = itemId
    }

    // Stop editing mode
    func stopEditing() {
        editingItemId = nil
    }
}
