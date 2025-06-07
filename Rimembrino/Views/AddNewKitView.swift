import SwiftUI




struct AddNewKitView: View {
    @ObservedObject var viewModel = AddNewKitViewModel() // ViewModel instance
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                PhotoPickerButton(viewModel: viewModel) // Photo selection button
                
                Form {
                    KitDetailsSection(viewModel: viewModel) // Kit details input
                    CalendarToggleSection(viewModel: viewModel) // Calendar toggle
                    
                    // List of Kit Items
                    KitItemList(viewModel: viewModel)
                    
                    if viewModel.isAddingNewItem {
                        KitItemForm(viewModel: viewModel) // Form for adding/editing KitItem
                    }
                }
                Spacer()
            }
            .navigationBarItems(
                leading: Button("Close") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save Kit") {
                    viewModel.addKits()
                    HomeViewModel.shared.saveKits()
                    presentationMode.wrappedValue.dismiss()
                
                }
            )
        }.ignoresSafeArea()
    }
}

#Preview {
    AddNewKitView()
}


struct PhotoPickerButton: View {
    @ObservedObject var viewModel: AddNewKitViewModel
    
    var body: some View {
        Button(action: {
            viewModel.isImagePickerPresented = true
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(viewModel.selectedColor)
                    .frame(width: 170, height: 100)
                    .shadow(radius: 10)
                
            }
        }
    }
}


struct KitDetailsSection: View {
    @ObservedObject var viewModel: AddNewKitViewModel
    
    var body: some View {
        Section {
            ColorPicker("Pick a Color", selection: $viewModel.selectedColor)
                .padding(.vertical, 5)
            TextField("Type kit name", text: $viewModel.kitModel.kitName)
        }
    }
}


struct CalendarToggleSection: View {
    @ObservedObject var viewModel: AddNewKitViewModel
    
    var body: some View {
        Section {
            Toggle("Add to Calendar", isOn: $viewModel.addToCalendar)
            
            if viewModel.addToCalendar {
                DatePicker("Select Date", selection: $viewModel.kitModel.selectedDate, displayedComponents: .date)
                DatePicker("Select Time", selection: $viewModel.kitModel.selectedTime, displayedComponents: .hourAndMinute)
            }
        }
    }
}

struct KitItemList: View {
    @ObservedObject var viewModel: AddNewKitViewModel
    
    var body: some View {
        Section(header: HStack {
            Text("Items").font(.headline)
            Spacer()
            Button(action: {
                viewModel.isAddingNewItem = true
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Add Item")
                }
            }
        }) {
            ForEach(viewModel.kitModel.items) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name).font(.headline)
                        Text(item.description).font(.subheadline).foregroundColor(.gray)
                    }
                    Spacer()
                    Button(action: {
                        viewModel.itemBeingEdited = item
                        viewModel.editedName = item.name
                        viewModel.editedDescription = item.description
                        viewModel.isAddingNewItem = true
                    }) {
                        Image(systemName: "pencil.circle.fill")
                    }
                    .buttonStyle(PlainButtonStyle())
                    Button(action: {
                        viewModel.deleteItem(KitItem: item)
                    }) {
                        Image(systemName: "minus.circle.fill").foregroundColor(.red)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

struct KitItemForm: View {
    @ObservedObject var viewModel: AddNewKitViewModel  // Reference to the ViewModel
    
    var body: some View {
        VStack {
            TextField("Item Name", text: $viewModel.editedName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.vertical, 5)
            
            TextField("Description (Optional)", text: $viewModel.editedDescription)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.vertical, 5)
            
            
            Button {
                viewModel.addItem()
            } label: {
                Text(viewModel.itemBeingEdited == nil ? "Add Kit Item" : "Save Changes")
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }.alert(isPresented: $viewModel.showAlert) {
                    Alert(
                        title: Text("Invalid Input"),
                        message: Text("KitItem name cannot be empty."),
                        dismissButton: .default(Text("OK"))
                    )
                }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(10)
    }
}
