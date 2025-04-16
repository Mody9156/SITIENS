//
//  ConfigureTimer.swift
//  SITIENS
//
//  Created by Modibo on 10/04/2025.
//

import SwiftUI

struct ConfiTimer: View {
    @State var second : Int
    @State var minute : Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Configurer la durée")
                .font(.largeTitle)
                .fontWeight(.bold)
           
            
            Section("configurer la durée") {
                TextField("Minute: ", value: $minute, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .frame(width: 80)
                
                TextField("Seconde: ", value: $second, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .frame(width: 80)
                    .border(.black,width: 3)
            }
            .padding()
            
            Button {
                
            } label: {
                ZStack {
                    Rectangle()
                        .frame(width: 80,height: 20)
                    
                    Text("Valider")
                        .font(.headline)
                        .foregroundStyle(.blue)
                }
                    
            }
        }
        
        .padding()
    }
}

#Preview {
    ConfiTimer(second: 70, minute: 60)
        .padding()
                  
}
