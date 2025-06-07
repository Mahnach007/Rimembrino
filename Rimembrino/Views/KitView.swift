//
//  KitView.swift
//  Rimembrino
//
//  Created by Vlad Gotovchykov on 09/10/24.
//

import SwiftUI

struct KitView: View {
    
    var model: KitModel
//    = KitModel(kitName: "Kit Name", color: ColorCodable(color: .blue))
    private let radius: CGFloat = 12

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: radius)
                .foregroundStyle(
                    model.color.toColor().opacity(1)
                )
                .overlay {
                    LinearGradient(colors: [.black,.clear], startPoint: .leading, endPoint: .trailing)
                        .cornerRadius(radius)
                        .opacity(0.2)
                }
                        
            VStack {
                Spacer()
                HStack {
                    Text(model.kitName)
                        .foregroundStyle(.white)
                        .bold()
                        .font(.system(size: 20))
                    Spacer()
                }
            }
            .padding(12)
                
        }
        .frame(width: 175, height: 99)
    }
}

#Preview {
    KitView(model: KitModel())
}
