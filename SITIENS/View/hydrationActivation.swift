import SwiftUI
import Combine
import WidgetKit
import UIKit

struct HydrationActivation: View {
    @State var timerIsReading = false
    @Bindable var hydrationActivationViewModel = HydrationActivationViewModel()
    @State var timeInterval: Int = 0
    @State var timeHour: Int = 0
    @State private var cancellable: Cancellable?
    @State private var soundPlayed = false
    @State var startDate: Date?
    @State var sheetPresented : Bool = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var rotationInfiny : Bool = false
    @State var selectedItems : String = "asphalt-sizzle"
    @AppStorage("hour",store: .standard) var timerhour : Int = 0//Attention
    @State var showMessage : Bool = false
    
    var body: some View {
        NavigationStack {
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
                        if timeInterval == 0  {
                            timeInterval = timerhour
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
                    
                    if timerhour == 0 {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundStyle(Color.orange)
                            Text("Veuillez bien selectionner un profil")
                        }
                        .opacity(timerhour == 0 ? 1 : 0)
                        .animation(
                            .easeOut(duration: 1.0),value: showMessage
                        )
                       
                        
                    }
                    
                }
                .toolbar(
                    content: {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                withAnimation {
                                    sheetPresented = true
                                }
                            } label: {
                                Image(systemName: "gearshape.fill")
                                    .font(.title2)
                                    .foregroundStyle(.primary)
                                    .rotationEffect(.degrees(rotationInfiny ? 360 : 0))
                                    .animation(
                                        .linear(duration: 2.9)
                                        .repeatForever(autoreverses: false),
                                        value: rotationInfiny
                                    )
                                    .onAppear{
                                        rotationInfiny = true
                                    }
                                
                            }
                            .sheet(isPresented: $sheetPresented) {
                                
                            } content: {
                                ConfiTimer(
                                    selectedItems: $selectedItems,
                                    selectedHour: $timeInterval, hydrationActivationViewModel: hydrationActivationViewModel
                                )
                            }
                        }
                    })
                
            }
            .onAppear {
                if timeInterval == 0 {
                    hydrationActivationViewModel.notification()
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    
                }
                
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
        }
        else {
            if timerIsReading && timeInterval != 0 && timeInterval != timerhour {
                return "STOPPER"
            } else if timeInterval < timerhour && timerhour == 0{
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
        startDate = Date()
        cancellable?.cancel()
        cancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                guard let start = startDate else { return }
                let elapsedTime = Int(Date().timeIntervalSince(start))
                let remainingTime = max(timerhour - elapsedTime, 0)
                timeInterval = remainingTime
                
                if timeInterval == 0 {
                    stopTimer()
                    hydrationActivationViewModel.notification()
                    hydrationActivationViewModel.playingSound(audioFile: selectedItems)
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
