//
//  Timer.swift
//  SITIENS
//
//  Created by Modibo on 08/04/2025.
//

import SwiftUI
import AVFoundation
import Combine

struct hydrationActivation: View {
    @State var timerIsReading = false
    @State private var autioPlayer : AVAudioPlayer?
    @StateObject var hydrationActivationViewModel  = HydrationActivationViewModel()
    @State var notification : Bool = false
    @State var timeInterval : Int = 10
    @State var activeToggle : Bool = false
    
    @State private var cancellable : Cancellable?
    
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
                Text("Temps restant: \(formatTimer(timeInterval)) secondes")
                    .foregroundStyle(.white)
                    .font(.title)
                    .padding()
                Toggle("Notification",isOn: $activeToggle).onChange(of: activeToggle) {
                    if activeToggle {
                        hydrationActivationViewModel.atuhorzation()
                    }
                   
                }
                
              
                
                Button {
                    withAnimation {
                        hydrationActivationViewModel.atuhorzation()
                        timerIsReading.toggle()
                        
                        if timerIsReading {
                            startTimer()
                        }else{
                            stopTimer()
                        }
                    }
                    
                } label: {
                    ZStack {
                        Circle()
                            .frame(height: 200)
                            .foregroundStyle(
                                timerIsReading && timeInterval != 0 ? .orange:.green
                            )
                        Text(timerIsReading && timeInterval != 0 ? "Stopper" : "Commencer")
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
            if timeInterval == 0 {
                hydrationActivationViewModel.notification()
            }
                
            
            
            startTimer()
            
        }
    }
    
    func startTimer(){
        
        cancellable?.cancel()
        
        cancellable = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if timeInterval > 0 {
                    timeInterval -= 1
                }else{
                    timeInterval = 0
                    hydrationActivationViewModel.notification()
                }
            }
        
    }
    
    func stopTimer(){
        cancellable?.cancel()
        timeInterval = 10  
    }
    
    func formatTimer(_ secondes :Int) -> String {
        let hours = secondes / 3600
        let minutes = (secondes % 3600) / 60
        let seconds = (secondes % 3600) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

#Preview {
    hydrationActivation()
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
