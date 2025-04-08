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
                
//                Text("\(time)")
//                    .fontWeight(.heavy)
//
                Text("\(Date.now.formatted(date: .omitted, time: .shortened))")
                
                Button {
                    withAnimation {
                        
                    }
                } label: {
                    ZStack {
                        Circle()
                            .frame(height: 100)
                        Text("Commencer")
                            .foregroundStyle(.white)
                        
                    }
                }

                
//                HStack {
//                    ActiveTimer(name: "lap")
//                    ActiveTimer(name: "Start")
//                }
                
            }
        }
    }
}

#Preview {
    Timer()
}

struct ActiveTimer: View {
    var name : String
    var body: some View {
        Button {
            
        } label: {
            ZStack {
                Circle()
                    .frame(height: 50)
                Text(name)
                    .foregroundStyle(.white)
                
            }
        }
    }
}
