import SwiftUI
import AVFoundation
import Combine
import WidgetKit

struct HydrationActivation: View {
    @State var timerIsReading = false
    @State private var audioPlayer: AVAudioPlayer?
    @Bindable var hydrationActivationViewModel = HydrationActivationViewModel()
    @State var notification: Bool = false
    @State var timeInterval: Int = 7200
    @State var activeToggle: Bool = false
    var timeManager: [TimeManager] = []
    @State var showNewView: Bool = false
    @State var scale: CGFloat = 1.0
    
    @State private var cancellable: Cancellable?
    
    var body: some View {
        ZStack {
            
            VStack {
                
                Text("Hydradation")
                    .foregroundStyle(.black)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Temps Restant")
                    .foregroundStyle(.black)
                    .font(.title3)
                    .fontWeight(.heavy)
                
                Text("\(formatTimer(timeInterval)) ")
                    .foregroundStyle(.black)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Button {
                    toggleTimer()
                } label: {
                    ZStack {
                        
                        Circle()
                            .frame(height: 200)
                            .foregroundStyle(.blue)
                        
                        Text(timerIsReading && timeInterval != 0 ? "STOPPER" : timeInterval < 7200 ? "REPRENDRE" :"COMMENCER")
                            .foregroundStyle(.black)
                            .font(
                                .system(size: 20, weight: .bold, design: .serif)
                            )
                    }
                }
                .overlay(content: {
                    Circle()
                        .stroke(
                            style: StrokeStyle(
                                lineWidth: 4,
                                lineCap: .round
                            ))
                        .foregroundStyle(.black)
                    
                })
                .buttonStyle(.plain)
                
                Button {
                    timeInterval = 10
                    stopTimer()
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 300,height: 50)
                            .foregroundStyle(Color("BackgroundColor"))
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black, lineWidth: 4)
                            }
                        
                        Text("Reinitialiser")
                            .foregroundStyle(.blue)
                            .font(
                                .system(size: 20, weight: .bold, design: .serif)
                            )
                    }
                }
                .padding()
            }
        }
        .onAppear {
            if timeInterval == 0 {
                hydrationActivationViewModel.notification()
            }
        }
    }
    
    
    func toggleTimer() {
        withAnimation {
            hydrationActivationViewModel.atuhorzation()
            
            timerIsReading.toggle()
            
            if timerIsReading {
                startTimer()
            } else {
                stopTimer()
            }
        }
    }
    
    func didDismiss() {
        // Handle dismissal if necessary
    }
    
    func startTimer() {
        cancellable?.cancel()
        
        cancellable = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if timeInterval > 0 {
                    timeInterval -= 1
                } else {
                    timeInterval = 0
                    hydrationActivationViewModel.notification()
                }
            }
    }
    
    func stopTimer() {
        cancellable?.cancel()
    }
    
    func formatTimer(_ secondes: Int) -> String {
        let hours = secondes / 3600
        let minutes = (secondes % 3600) / 60
        let seconds = (secondes % 3600) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

#Preview {
    HydrationActivation()
}

