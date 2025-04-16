//
//  ConfigureTimer.swift
//  SITIENS
//
//  Created by Modibo on 10/04/2025.
//

import SwiftUI

struct ConfiTimer: View {
    @State var sound : [String] = ["asphalt-sizzle","clover-feast","fresh-breeze"]
    
    var body: some View {
        VStack{
            Text("Configuration")
                .font(.largeTitle)
                .fontWeight(.bold)
                .lineLimit(2)
            
            Spacer()
          
            
            
            Button {
                
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
    ConfiTimer()
        .padding()
                  
}
