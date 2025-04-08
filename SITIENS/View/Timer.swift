//
//  Timer.swift
//  SITIENS
//
//  Created by Modibo on 08/04/2025.
//

import SwiftUI

struct Timer: View {
    @State var startDate = Date.now
    @State var time : Int = 0
    
    var body: some View {
        ZStack{
            Color("BackgroundColor")
                .ignoresSafeArea()
            VStack {
                Text("Chronomètre")
                Text("Temps : \(time)")
                
                Button {
                    
                } label: {
                    Text("lap")
                }
                
                Button {
                    
                } label: {
                    Text("Start")
                }
                
                
            }
            
        }
    }
}

#Preview {
    Timer()
}
