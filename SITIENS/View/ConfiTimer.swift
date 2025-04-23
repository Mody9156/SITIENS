//
//  ConfigureTimer.swift
//  SITIENS
//
//  Created by Modibo on 10/04/2025.
//

import SwiftUI
import UIKit

struct ConfiTimer: View {
    @State var sound : [String] = ["asphalt-sizzle","clover-feast","fresh-breeze"]
    @State var hour : [Int] = [3600,7200,10800]
    @Binding var selectedItems : String
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            VStack{
                Text("Configuration")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.blue)
                    .lineLimit(2)
                
                
                
                Spacer()
                
                Text("Sélectionner Un temps d'hydratation")
                    .font(.headline)
                    .padding()
                
                    Text("Sélectionner l'audio")
                        .font(.headline)
                
                    Picker("", selection: $selectedItems) {
                        ForEach(sound,id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.wheel)
                
                
                Spacer()
                
                Button {
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                    generator.impactOccurred()
                    dismiss()
                } label: {
                    Text("Valider")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 2)
                    
                }
            }
            
            .padding()
        }
    }
}

#Preview {
    @Previewable @State var selectedItems : String = "asphalt-sizzle"
    ConfiTimer(selectedItems: $selectedItems)
        .padding()
    
}
