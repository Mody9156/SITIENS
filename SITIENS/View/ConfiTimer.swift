//
//  ConfigureTimer.swift
//  SITIENS
//
//  Created by Modibo on 10/04/2025.
//

import SwiftUI
import UIKit
import AVFAudio
import Combine

struct ConfiTimer: View {
    @State var sound : [String] = ["asphalt-sizzle","clover-feast","fresh-breeze"]
    @State var hour : [Int] = [3600,7200]
    @Binding var selectedItems : String
    @Binding var selectedHour : Int
    @Environment(\.dismiss) var dismiss
    @Bindable var hydrationActivationViewModel : HydrationActivationViewModel
    @AppStorage("hour",store: .standard) var timerhour : Int = 0
    @State private var audio : AVAudioPlayer?
    @State private var isPlaying : Bool = false
    @State private var cancellable: Cancellable?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: 30){
                    Text("Configuration")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.blue)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                    
                    
                    VStack {
                        Text("Sélectionner Un temps d'hydratation")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Picker("", selection: $selectedHour) {
                            ForEach(hour,id: \.self) {
                               
                                Text("\(hydrationActivationViewModel.formatHour($0)) Hour\($0 == 3600 ? "" : "s")")
                            }
                        }
                        .pickerStyle(.palette)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .shadow(radius: 5)
                    
                    VStack {
                        Text("Sélectionner l'audio")
                            .font(.headline)
                        Picker("", selection: $selectedItems) {
                            ForEach(sound,id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.palette)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .shadow(radius: 5)
                    
                   Text("Jouer l'audio")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Button {
                        withAnimation {
                            isPlaying.toggle()
                            
                            if isPlaying {
                                hydrationActivationViewModel.playSound(sound: selectedItems)
                            }else{
                                hydrationActivationViewModel.audioPlayer = nil
                            }
                        }

                    } label: {
                        Image(systemName:isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .resizable()
                            .frame(width: 80,height: 80)
                            .padding()
                            .scaleEffect(isPlaying ? 1.1 : 1.0)
                        
                    }
                    .onAppear{
                        isPlaying = false
                    }

                }
                .padding()
            }
            
            Spacer()
            
            Button {
                
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    timerhour = selectedHour
                    hydrationActivationViewModel.stopPlaying()
                    dismiss()
                }
            } label: {
                Text("Valider")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(16)
                    .shadow(radius: 8)
                
            }
            .padding()
        }
    }
}

#Preview {
    @Previewable @State var selectedItems : String = "asphalt-sizzle"
    @Previewable @State var selectedHour : Int = 7200
    ConfiTimer(
        selectedItems: $selectedItems,
        selectedHour: $selectedHour,
        hydrationActivationViewModel: HydrationActivationViewModel()
    )
}
