//
//  Start_timer.swift
//  SITIENS
//
//  Created by Modibo on 22/05/2025.
//

import SwiftUI
import Combine

struct Start_timer: View {
    @Binding var showMessage : Bool
    @Bindable var hydrationActivationViewModel : HydrationActivationViewModel
    @Binding var timeInterval: Int
    @Binding var timerIsReading : Bool
    @AppStorage("hour",store: .standard) var timerhour : Int = 0
    @Binding  var cancellable: Cancellable?
    @Binding var startDate: Date?
    @Binding var elapseBeforPause : Int
    @State var selectedItems : String
    var nameBtm : String
    @State private var animeFrame : CGFloat = 1.0

    
    var body: some View {
        
        if nameBtm == "Start" {
            if  buttonLabel == "Démarrer" && buttonLabel != "Arrêter"  {
            Button {
                    timerIsReading = false
                    timeInterval = timerhour
                    stopTimer()
                    
                    if timerhour == 0 && timeInterval == 0 {
                        DispatchQueue.main
                            .asyncAfter(deadline: .now() + 0.2, execute: {
                                withAnimation {
                                    showMessage = true
                                }
                            })
                    }
            } label: {
                ZStack {
                    Circle()
                        .fill(.gray)
                        .frame(width: 13, height: 13)
                        .shadow(radius: 10)
                    
                    Circle()
                        .fill(.white)
                        .frame(width: 125, height: 125)
                        .shadow(radius: 10)
                    
                    Circle()
                        .fill(.gray)
                        .frame(width: 120, height: 120)
                        .shadow(radius: 10)
                    
                    
                    Text("Réinitialiser")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
            }
            .buttonStyle(.plain)
            .padding()
        }
        }else{
            Button {
                showMessage = false
                toggleTimer()

                if timerhour == 0 && timeInterval == 0 {
                    DispatchQueue.main
                        .asyncAfter(deadline: .now() + 0.2, execute: {
                            withAnimation {
                                showMessage = true
                            }
                        })
                }
            } label: {
                ZStack {
                    Circle()
                        .fill(fill)
                        .frame(width: 13, height: 13)
                        .shadow(radius: 10)
                    
                    Circle()
                        .fill(.white)
                        .frame(width: 125, height: 125)
                        .shadow(radius: 10)
                    
                    if  buttonLabel == "Arrêter" {
                        Circle()
                            .fill(.red)
                            .scaleEffect(animeFrame)
                            .frame(width:  120, height:  120)
                            .shadow(radius: 10)
                            .animation(
                                .easeIn(
                                    duration: 2)
                                .repeatForever(),
                                
                                value: animeFrame
                            )
                        
                            .onAppear{
                                withAnimation {
                                    animeFrame = 1.5
                                }
                            }
                            .onChange(of: animeFrame, {
                                withAnimation {
                                    animeFrame = 1.0
                                }
                            })
                    }
                    
                    Circle()
                        .fill(fill)
                        .frame(width: 120, height: 120)
                        .shadow(radius: 10)
                    
                    Text(buttonLabel)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
            }
            .buttonStyle(.plain)
            .padding()
        }
    }
    
    func toggleTimer() {
        withAnimation {
            hydrationActivationViewModel.authorization()
            timerIsReading.toggle()
            if  timerIsReading {
                startTimer()
            }else{
                stopTimer()
            }
        }
    }
    
    var fill : Color {
        switch buttonLabel{
        case "Démarrer" :
            return .green
        case "Arrêter" :
            return .red
        default:
            return .gray
        }
    }
    
    func stopTimer() {
        cancellable?.cancel()
        hydrationActivationViewModel.stopPlaying()
        if let start = startDate {
            let elapsedTime = Int(Date().timeIntervalSince(start))
            elapseBeforPause += elapsedTime
        }
    }
    
    var buttonLabel: String {
        
        if timerIsReading && timeInterval != 0 && timeInterval != timerhour {
            return "Arrêter"
        } else {
            return "Démarrer"
        }
    }
    
    func startTimer() {
        startDate = Date()
        cancellable?.cancel()
        cancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                guard let start = startDate else { return }
                let elapsedTime = elapseBeforPause + Int(Date().timeIntervalSince(start))
                let remainingTime = max(timerhour - elapsedTime, 0)
                timeInterval = remainingTime
                
                if timeInterval == 0 {
                    stopTimer()
                    hydrationActivationViewModel.notification()
                    hydrationActivationViewModel.playingSound(audioFile: selectedItems)
                    elapseBeforPause = 0
                }
            }
    }
}


#Preview {
    @Previewable @State var showMessage : Bool = false
    @Previewable @State var timeInterval : Int = 0
    @Previewable @State var timerIsReading : Bool = false
    @Previewable @State var cancellable : Cancellable? = nil
    @Previewable @State var startDate : Date? = Date.now
    @Previewable @State var elapseBeforPause : Int = 12
    @Previewable @State var selectedItems : String = "fakeTest"
    @Previewable @State var activeTrim : Bool = true
    @Previewable @State var hydrationActivationViewModel  = HydrationActivationViewModel()

    HStack {
        Start_timer(
            showMessage: $showMessage, hydrationActivationViewModel: hydrationActivationViewModel,
            timeInterval: $timeInterval,
            timerIsReading: $timerIsReading,
            cancellable: $cancellable,
            startDate: $startDate,
            elapseBeforPause: $elapseBeforPause,
            selectedItems: selectedItems, nameBtm: "Start"
        )
        
        Start_timer(
            showMessage: $showMessage, hydrationActivationViewModel: hydrationActivationViewModel,
            timeInterval: $timeInterval,
            timerIsReading: $timerIsReading,
            cancellable: $cancellable,
            startDate: $startDate,
            elapseBeforPause: $elapseBeforPause,
            selectedItems: selectedItems, nameBtm: "stop"
        )
    }
}
