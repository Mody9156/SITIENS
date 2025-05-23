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
    @Bindable var hydrationActivationViewModel = HydrationActivationViewModel()
    @Binding var timeInterval: Int
    @Binding var timerIsReading : Bool
    @AppStorage("hour",store: .standard) var timerhour : Int = 0
    @Binding  var cancellable: Cancellable?
    @Binding var startDate: Date?
    @Binding var elapseBeforPause : Int
    @State var selectedItems : String
    var nameBtm : String
    
    var firstButtonLabel : String {
//        if  timeInterval < timerhour {
            return "Réinitialiser"
    }
    
    var body: some View {
        
        if nameBtm == "Start" {
            
            if  timeInterval == 0 || buttonLabel == "REPRENDRE"  {
                Button {
                   
                    
                    timeInterval = timerhour
                    stopTimer()
                    hydrationActivationViewModel.stopPlaying()
                    
                    DispatchQueue.main
                        .asyncAfter(deadline: .now() + 0.2, execute: {
                            withAnimation {
                                showMessage = true
                            }
                        })
                    
                } label: {
                    ZStack {
                        Circle()
                            .fill(.gray)
                            .frame(width: 120, height: 120)
                            .shadow(radius: 10)
                        //                                .scaleEffect(timerIsReading ? 1.05 : 1)
                        //                                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: timerIsReading)
                        
                        Text(firstButtonLabel)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                }
                .buttonStyle(.plain)
                .animation(.spring(), value: timerIsReading)
                .padding()
            }
        }else{
            Button {
                toggleTimer()
                showMessage = false
//                
//                if timeInterval == 0{
//                    timeInterval = timerhour
//                    stopTimer()
//                    hydrationActivationViewModel.stopPlaying()
//                }
//
//                if timerhour == 0 && timeInterval == 0 {
//                    DispatchQueue.main
//                        .asyncAfter(deadline: .now() + 0.2, execute: {
//                            withAnimation {
//                                showMessage = true
//                            }
//                        })
//                }
                
            } label: {
                ZStack {
                    Circle()
                        .fill(fill)
                        .frame(width: 120, height: 120)
                        .shadow(radius: 10)
                    //                                .scaleEffect(timerIsReading ? 1.05 : 1)
                    //                                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: timerIsReading)
                    
                    Text(buttonLabel)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
            }
            .buttonStyle(.plain)
            .animation(.spring(), value: timerIsReading)
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
        case "REPRENDRE" :
            return Color("ToResume")
        case "COMMENCER" :
            return Color("ToBegin")
        default:
            return .gray
        }
    }
    
   
    
    func stopTimer() {
        cancellable?.cancel()
        if let start = startDate {
            let elapsedTime = Int(Date().timeIntervalSince(start))
            elapseBeforPause += elapsedTime
        }
    }
    
    var buttonLabel: String {
        
            if timerIsReading && timeInterval != 0 && timeInterval != timerhour {
                return "STOPPER"
            } else if timeInterval < timerhour {
                return "REPRENDRE"
            } else {
                return "COMMENCER"
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
    
    HStack {
        Start_timer(
            showMessage: $showMessage,
            timeInterval: $timeInterval,
            timerIsReading: $timerIsReading,
            cancellable: $cancellable,
            startDate: $startDate,
            elapseBeforPause: $elapseBeforPause,
            selectedItems: selectedItems, nameBtm: "Start"
        )
        Start_timer(
            showMessage: $showMessage,
            timeInterval: $timeInterval,
            timerIsReading: $timerIsReading,
            cancellable: $cancellable,
            startDate: $startDate,
            elapseBeforPause: $elapseBeforPause,
            selectedItems: selectedItems, nameBtm: "stop"
        )
    }
}
