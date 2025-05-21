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
    @State var hour : [Int] = [3600,7200,5400,1800]
    @Binding var selectedItems : String
    @Binding var selectedHour : Int
    @Environment(\.dismiss) var dismiss
    @Bindable var hydrationActivationViewModel : HydrationActivationViewModel
    @AppStorage("hour",store: .standard) var timerhour : Int = 0
    @State private var audio : AVAudioPlayer?
    @State  var isPlaying : Bool = false
    @State private var cancellable: Cancellable?
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: 30){
                    
                    VStack {
                        Text("Sélectionner Un temps d'hydratation")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Picker(
                            selection: $selectedHour,
                            label: Text(
                                selectedHour == 0 ? "Sélectionner" : "Temps sélectionné"
                            )
                        ) {
                            ForEach(hour,id: \.self) {
                                
                                Text(hydrationActivationViewModel.formatHour($0))
                                    .lineLimit(1)
                                
                            }
                        }
                        .pickerStyle(.navigationLink)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .navigationTitle("Configuration")
                        .navigationBarTitleDisplayMode(.inline)
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
                    
                    CustomButton(
                        isPlaying: $isPlaying,
                        hydrationActivationViewModel: hydrationActivationViewModel, selectedItems: $selectedItems, type: "LoadingSong", selectedHour: $selectedHour
                    )
                }
                .padding()
            }
            
            Spacer()
            
            CustomButton(
                isPlaying: $isPlaying,
                hydrationActivationViewModel: hydrationActivationViewModel, selectedItems: $selectedItems, type: "Validate", selectedHour: $selectedHour
            )
        }
    }
}

#Preview {
    @Previewable @State var selectedItems : String = "asphalt-sizzle"
    @Previewable @State var selectedHour : Int = 0
    ConfiTimer(
        selectedItems: $selectedItems,
        selectedHour: $selectedHour,
        hydrationActivationViewModel: HydrationActivationViewModel()
    )
}

struct CustomButton: View {
    @Binding var isPlaying : Bool
    @Bindable var hydrationActivationViewModel : HydrationActivationViewModel
    @Binding var selectedItems : String
    var type : String
    @AppStorage("hour",store: .standard) var timerhour : Int = 0
    @Binding var selectedHour : Int
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        if type == "LoadingSong" {
            Button {
                withAnimation {
                    isPlaying.toggle()
                    
                    if isPlaying {
                        hydrationActivationViewModel.playSound(sound: selectedItems)
                    }else{
                        hydrationActivationViewModel.stopPlaying()
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
        }else{
            Button {
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    timerhour = selectedHour
                    hydrationActivationViewModel.stopPlaying()
                    if selectedHour != 0  {
                        dismiss()
                    }
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 50)
                    Text("Valider")
                        .foregroundStyle(.white)
                }
            }
            .disabled(selectedHour == 0)
            .padding()
        }
    }
}
