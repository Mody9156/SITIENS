import SwiftUI
import Combine
import WidgetKit
import UIKit
import CoreData

struct Chronograph: View {
    @State var timerIsReading = false
    @Bindable var hydrationActivationViewModel = HydrationActivationViewModel()
    @State var timeInterval: Int = 0
    @State private var cancellable: Cancellable?
    @State private var soundPlayed = false
    @State var startDate: Date?
    @State var sheetPresented : Bool = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var rotationInfiny : Bool = false
    @State var selectedItems : String = ""
    @AppStorage("hour",store: .standard) var timerhour : Int = 0//Attention
    @State var showMessage : Bool = false
    @State var elapseBeforPause : Int = 0
    
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
                    
                    // Bouton du cercle principal
                    Button {
                        toggleTimer()
                        showMessage = false
                        
                        if timeInterval == 0{
                            timeInterval = timerhour
                            stopTimer()
                            hydrationActivationViewModel.stopPlaying()
                        }
                        
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
                                .frame(width: 200, height: 200)
                                .shadow(radius: 10)
//                                .scaleEffect(timerIsReading ? 1.05 : 1)
//                                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: timerIsReading)
                            
                            Text(buttonLabel)
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                        }
                    }
                    .buttonStyle(.plain)
                    .animation(.spring(), value: timerIsReading)
                    
                    if showMessage{
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundStyle(Color.orange)
                            Text("Veuillez bien selectionner l'horraire")
                        }
                        .opacity(showMessage ? 1 : 0)
                        .animation(
                            .easeOut(duration: 1.0),value: showMessage
                        )
                        .padding()
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
                
                showMessage = false
            }
        }
    }
    
    var fill : Color {
        switch buttonLabel{
        case "Réinitialiser" :
            return Color("ToReboot")
        case "REPRENDRE" :
            return Color("ToResume")
        case "COMMENCER" :
            return Color("ToBegin")
        default:
            return .gray
        }
    }
    
    var buttonLabel: String {
        if timeInterval == 0 {
            return "Réinitialiser"
        }
        else {
            if timerIsReading && timeInterval != 0 && timeInterval != timerhour {
                return "STOPPER"
            } else if timeInterval < timerhour {
                return "REPRENDRE"
            } else {
                return "COMMENCER"
            }
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
    
    func stopTimer() {
        cancellable?.cancel()
        if let start = startDate {
            let elapsedTime = Int(Date().timeIntervalSince(start))
            elapseBeforPause += elapsedTime
        }
    }
}

#Preview {
    Chronograph()
}
