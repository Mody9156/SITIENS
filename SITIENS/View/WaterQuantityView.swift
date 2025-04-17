//
//  WaterQuantityView.swift
//  SITIENS
//
//  Created by Modibo on 16/04/2025.
//

import SwiftUI

struct WaterQuantityView: View {
    @State var updateHeight : CGFloat = 0
    @State var title : String = "150ml"
    @State var nameOfCategory : String = "Nourrisson"
    var body: some View {
        NavigationStack {
            VStack{
                
                Text("\(Int((updateHeight / 2) * 200 / 300)) %")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.blue)
                    .padding()
                
                
                Text("\(Int(updateHeight / 2))ml / \(title)")
                    .foregroundStyle(.gray)
                
                ZStack (alignment: .bottom){
                    RoundedRectangle(cornerRadius: 6)
                        .frame(width: 200,height: 300)
                        .foregroundStyle(.white)
                        .overlay {
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.blue, lineWidth: 2)
                        }
                    
                    RoundedRectangle(cornerRadius: 6)
                        .frame(width: 200,height: updateHeight)
                        .foregroundStyle(.blue)
                        .overlay {
                            RoundedRectangle(cornerRadius: 6)
                                .foregroundStyle(Color.blue)
                        }
                }
                .padding()
                
                Button {
                    withAnimation {
                        if updateHeight != 300 {
                            updateHeight += 12.5
                        }
                    }
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 200,height: 50)
                        Text(updateHeight == 300 ? "Objectif atteint" : "Ajouter de l'eau")
                            .foregroundStyle(.white)
                    }
                }
                .padding()
                
                
            }
        }
    }
}

#Preview {
    WaterQuantityView()
}
