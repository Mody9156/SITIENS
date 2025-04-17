//
//  WaterQuantityView.swift
//  SITIENS
//
//  Created by Modibo on 16/04/2025.
//

import SwiftUI

struct WaterQuantityView: View {
    @State var updateHeight : CGFloat = 0
    var body: some View {
        VStack{
            Text("Quantité d'eau")
            ZStack (alignment: .bottom){
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 200,height: 300)
                    .foregroundStyle(.white)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.blue, lineWidth: 2)
                    }
                
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 200,height: updateHeight)
                    .foregroundStyle(.blue)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.blue)
                    }
            }
            .padding()
            
            Button {
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 200,height: 50)
                    Text("Ajouter de l'eau")
                        .foregroundStyle(.white)
                }
            }
            .padding()

                
        }
    }
}

#Preview {
    WaterQuantityView()
}
