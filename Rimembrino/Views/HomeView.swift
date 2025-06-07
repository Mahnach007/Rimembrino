import SwiftUI

struct HomeView: View {
    
    @State private var isAddKitViewPresented: Bool = false
    @State private var isItemKitListViewPresented: Bool = false
    @StateObject private var viewModel = HomeViewModel.shared
    @State private var isFirstAnimationComplete = false
    @State private var currentKit: KitModel?
    
    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible())
      ]
    
    var body: some View {
        VStack(spacing: 20) {
            
            HStack {
                Image(systemName: "gear")
                    .foregroundStyle(.blue)
                    .font(.system(size: 25))
                Spacer()
                
                Button {
                    isAddKitViewPresented = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(.blue)
                        .font(.system(size: 25))
                }


            }.padding(.horizontal, 16)
            
            VStack {
                if !isFirstAnimationComplete {
                                LottieView(animationName: "elephant", loopMode: .playOnce) {
                                    isFirstAnimationComplete = true
                                }
                                .frame(width: 450, height: 300)
                            } else {

                                LottieView(animationName: "elephant-static")
                                    .frame(width: 450, height: 300)
                            }
            }
            .frame(width: 370, height: 300)
            
            Text("Main Kits")
                .font(.title2)
                .bold()
                .frame(width: 370 , alignment: .leading)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(viewModel.kitList) { kit in
                        KitView(model: kit)
                            .contextMenu {
                                Button {
                                    viewModel.deleteKitView(kit: kit)
                                } label: {
                                    Text("Delete")
                                }
                                Button {
                                    viewModel.pinOnTop(kit: kit)
                                } label: {
                                    Text("Pin On Top")
                                }
                            }
                            .onTapGesture {
                                currentKit = kit
                                isItemKitListViewPresented = true
                        }
                    }
                }
                
            }.padding()
            
        }.onAppear {
            viewModel.loadKits()
        }
        .sheet(isPresented: $isAddKitViewPresented) {
            AddNewKitView()
        }
        .sheet(isPresented: $isItemKitListViewPresented) {
            if let currentKit {
                let viewModel = KitItemListViewModel(kit: currentKit)
                KitItemListView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(MapViewModel())
}
