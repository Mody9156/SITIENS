//
//  ConfigureTimer.swift
//  SITIENS
//
//  Created by Modibo on 10/04/2025.
//

import SwiftUI

struct ConfiTimer: View {
    @State var sound : [String] = ["asphalt-sizzle","clover-feast","fresh-breeze"]
    @Binding var selectedItems : String
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            Text("Configuration")
                .font(.largeTitle)
                .fontWeight(.bold)
                .lineLimit(2)
            
            Spacer()
          
            VStack{
                Text("Selectionner l'audio")
                    .font(.headline)
                    .fontWeight(.bold)
                
                VStack {
                    Picker("Selectionner l'audio", selection: $selectedItems) {
                        ForEach(sound,id: \.self) { sound in
                            Text(sound)
                        }
                    }
                    .pickerStyle(.segmented)
                }
              
              
            }
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 40)
                    
                    Text("Valider")
                        .font(.headline)
                        .foregroundStyle(.white)
                }
                    
            }
        }
        
        .padding()
    }
}

#Preview {
    @Previewable @State var selectedItems : String = "asphalt-sizzle"
    ConfiTimer(selectedItems: $selectedItems)
        .padding()
                  
}
