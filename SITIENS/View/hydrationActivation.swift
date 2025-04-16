import SwiftUI
import Combine
import WidgetKit
import UIKit

struct HydrationActivation: View {
    @State var timerIsReading = false
    @Bindable var hydrationActivationViewModel = HydrationActivationViewModel()
    @State var timeInterval: Int = 10
    @State private var cancellable: Cancellable?
    @State private var soundPlayed = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                gradient: Gradient(colors: [.blue.opacity(0.3), .cyan.opacity(0.2)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 32) {
                VStack(spacing: 4) {
                    Text("Hydratation")
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                    
                    Text("Temps restant")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }

                Text(hydrationActivationViewModel.formatTimer(timeInterval))
                    .font(.system(size: 48, weight: .bold, design: .monospaced))
                    .foregroundStyle(.primary)

                // Bouton cercle principal
                Button {
                    toggleTimer()
                    if timeInterval == 0 {
                        timeInterval = 10
                        stopTimer()
                        hydrationActivationViewModel.stopPlaying()
                    }
                  
                } label: {
                    ZStack {
                        Circle()
                            .fill(fill)
                            .frame(width: 200, height: 200)
                            .shadow(radius: 10)
                            .scaleEffect(timerIsReading ? 1.05 : 1)
                            .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: timerIsReading)

                        Text(buttonLabel)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                }
                .buttonStyle(.plain)
                .animation(.spring(), value: timerIsReading)

            }
            .padding()
        }
        .onAppear {
            if timeInterval == 0 {
                hydrationActivationViewModel.notification()
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                
            }
        }
       
    }

    var fill : Color {
        switch buttonLabel{
        case "Réinitialiser" :
            return .orange
        case "REPRENDRE" :
            return .orange
        case "COMMENCER" :
            return .blue
        default:
            return .blue
        }
    }
    var buttonLabel: String {
        if timeInterval == 0 {
            
            return "Réinitialiser"
        } else {
            if timerIsReading && timeInterval != 0 && timeInterval != 10 {
                return "STOPPER"
            } else if timeInterval < 10 {
                return "REPRENDRE"
            } else {
                return "COMMENCER"
            }
        }
    }

    func toggleTimer() {
        withAnimation {
            hydrationActivationViewModel.atuhorzation()
            timerIsReading.toggle()
            timerIsReading ? startTimer() : stopTimer()
        }
    }
  
    func startTimer() {
        cancellable?.cancel()
        cancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if timeInterval > 0 {
                    timeInterval -= 1
                }else {
                    stopTimer()
                    timeInterval = 0
                    hydrationActivationViewModel.notification()
                   
                     hydrationActivationViewModel
                            .playingSound(audioFile: "fresh-breeze-321612")
                   
                }
            }
    }

    func stopTimer() {
        cancellable?.cancel()
    }

}

#Preview {
    HydrationActivation()
}
