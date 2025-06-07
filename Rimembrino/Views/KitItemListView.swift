import SwiftUI

struct KitItemListView: View {
    
    @StateObject var viewModel: KitItemListViewModel
    @State private var isAddingNewItem = false
    @State private var editedName = ""
    @State private var editedDescription = ""
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentationMode
//    @State var isChnaged = false

    var body: some View {
        NavigationView {
            List {
                headerView // Display header with "Add Item" button

                ForEach(viewModel.kit.items) { item in
                    itemView(item: item) // Display each item with edit and checklist functionality
                }

                // Show the form for adding a new item if required
                if isAddingNewItem {
                    addItemForm
                }
            }
            .navigationTitle(viewModel.kit.kitName)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save Kit") {
            
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }

    // Header with "Items" and "Add Item" button
    var headerView: some View {
        HStack {
            Text("Items:")
                .font(.headline)
            Spacer()
            Button(action: {
                isAddingNewItem = true
                editedName = ""
                editedDescription = ""
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Add Item")
                }
            }
        }
        .padding(.vertical, 8)
    }

    // View for individual items
    func itemView(item: KitItem) -> some View {
        VStack(alignment: .leading) {
            HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                            .onTapGesture {
                                viewModel.startEditing(itemId: item.id)
                                editedName = item.name
                                editedDescription = item.description
                            }
                        Text(item.description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                Button {
//                    isChnaged.toggle()
                    viewModel.toggleChecklist(item: item)
//                  item.isSelected.toggle()
                } label: {
                    Image(systemName: item.isSelected ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(item.isSelected ? .green : .gray)
                        .font(.title2)
                }

            }
            .padding(.vertical, 5)
            .swipeActions {
                // Swipe to delete the item
                Button(role: .destructive) {
//                    kit.items.remove(at: kit.items.firstIndex(of: item)!)
//                    viewModel.deleteItem(item: item)
                    viewModel.deleteItem(item: item)
                } label: {
                    Label("Delete", systemImage: "trash")
                }
                .tint(.red)
            }

            // Edit form shown under the item if it's being edited
            if viewModel.editingItemId == item.id {
                editItemForm(item: item)
            }
        }
    }

    // Edit form for the selected item
    func editItemForm(item: KitItem) -> some View {
        VStack {
            TextField("Item Name", text: $editedName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.vertical, 5)

            TextField("Description (Optional)", text: $editedDescription)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.vertical, 5)

            Button(action: {
                if editedName.isEmpty {
                    showAlert = true
                } else {
                    viewModel.updateItem(item: item, newTitle: editedName, newDescription: editedDescription)
                    viewModel.stopEditing()
                }
            }) {
                Text("Save Changes")
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 10)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Invalid Input"), message: Text("Item name cannot be empty."), dismissButton: .default(Text("OK")))
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(10)
    }

    // Form to add a new item
    var addItemForm: some View {
        VStack {
            TextField("Item Name", text: $editedName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.vertical, 5)

            TextField("Description (Optional)", text: $editedDescription)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.vertical, 5)

            Button(action: {
                if editedName.isEmpty {
                    showAlert = true
                } else {
                    viewModel.addItem(title: editedName, subtitle: editedDescription)
                    isAddingNewItem = false
                }
            }) {
                Text("Add Item")
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 10)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Invalid Input"), message: Text("Item name cannot be empty."), dismissButton: .default(Text("OK")))
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(10)
    }
}
