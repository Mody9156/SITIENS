//
//  Timer.swift
//  SITIENS
//
//  Created by Modibo on 08/04/2025.
//

import SwiftUI
import AVFoundation

struct hydrationActivation: View {
    @State var startDate = Date.now
    @State var timeRemaining : Int = 60
    @State var timerIsReading = false
    @State private var autioPlayer : AVAudioPlayer?
    @StateObject var hydrationActivationViewModel : HydrationActivationViewModel
    
    var body: some View {
        ZStack{
            Color("BackgroundColor")
                .ignoresSafeArea()
            VStack {
                Text("Chronomètre")
                
//                Gauge(value: 0.5, in: 0...1) {
//                    Text("Label")
//                }
//                Text("\(time)")
//                    .fontWeight(.heavy)
//
                Text("\(Date.now.formatted(date: .omitted, time: .shortened))")
                    .font(.system(size: 100, weight: .heavy))
                    .foregroundStyle(.white)
                
                Button {
                    withAnimation {
                        
                    }
                } label: {
                    ZStack {
                        Circle()
                            .frame(height: 200)
                        Text("Commencer")
                            .foregroundStyle(.white)
                        
                    }
                }
                .buttonStyle(.plain)

                
//                HStack {
//                    ActiveTimer(name: "lap")
//                    ActiveTimer(name: "Start")
//                }
                
            }
        }
        .onAppear{
            hydrationActivationViewModel.notification()
        }
    }
}

#Preview {
    hydrationActivation(hydrationActivationViewModel: HydrationActivationViewModel())
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
