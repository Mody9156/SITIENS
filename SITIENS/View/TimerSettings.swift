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

struct TimerSettings: View {
    @State var sound : [String] = ["asphalt-sizzle","clover-feast","fresh-breeze","alone","kugelsicher-by-tremoxbeatz","gardens-stylish-chill","future-design","lofi-effect","lofi-sample-if-i-cant-have-you","mystical-music","music-box","meditation-music-sound-bite","ringtone","cool-guitar-loop","basique"]
    @State var hour : [Int] = [3600,7200,5400,1800]
    @Binding var selectedItems : String
    @Binding var selectedHour : Int
    @Environment(\.dismiss) var dismiss
    @Bindable var hydrationActivationViewModel : HydrationActivationViewModel
    @AppStorage("hour",store: .standard) var timerhour : Int = 0
    @State private var audio : AVAudioPlayer?
    @State  var isPlaying : Bool = false
    @State private var cancellable: Cancellable?
    @State private var navigationTitle : String = "Configuration"
    @State private var slide : Double = 0.0
    @State private var activeSlide : Bool = false
 
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: 30){
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Sélectionner le temps")
                            .font(.headline)
                            .padding(.horizontal, 4)

                        Picker(
                            selection: $selectedHour,
                            label: HStack {
                                Text(
                                    selectedHour == 0
                                    ? "Sélectionner"
                                    : hydrationActivationViewModel.formatHour(selectedHour)
                                )
                                .foregroundColor(selectedHour == 0 ? .gray : .primary)
                                .lineLimit(1)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                        ) {
                            ForEach(hour, id: \.self) { value in
                                Text(hydrationActivationViewModel.formatHour(value))
                                    .lineLimit(1)
                            }
                        }
                        .pickerStyle(.navigationLink)
                        .padding()
                        .background(Color(uiColor: .systemBlue))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                        )
                        .accessibilityLabel("Sélection du temps")
                        .accessibilityHint("Appuyez pour choisir une durée")
                    }
                    .padding()
                    .background(Color(
                        .blue)
                        .opacity(0.4)
                    )
                    .cornerRadius(16)
                    .shadow(radius: 5)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Sélectionner l'audio")
                            .font(.headline)
                            .padding(.horizontal, 4)

                        Picker(selection: $selectedItems, label: HStack {
                            Text(selectedItems.isEmpty ? "Sélectionner" : selectedItems)
                                .foregroundColor(selectedItems.isEmpty ? .gray : .primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }) {
                            ForEach(sound, id: \.self) { item in
                                Text(item)
                            }
                        }
                        .pickerStyle(.navigationLink)
                        .padding()
                        .background(Color(uiColor: .systemBlue))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                        )
                        .accessibilityLabel("Sélectionner un son")
                        .accessibilityHint("Double-cliquez pour choisir un audio")
                    }
                  
                    .padding()
                    .background(Color(
                        .blue)
                        .opacity(0.4)
                    )
                    .cornerRadius(16)
                    .shadow(radius: 5)
                    
                    Text(isPlaying ? "Stopper l'audio" : "Jouer l'audio")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    CustomButton(
                        isPlaying: $isPlaying,
                        hydrationActivationViewModel: hydrationActivationViewModel, selectedItems: $selectedItems, type: "LoadingSong", selectedHour: $selectedHour
                    )
                }
                .padding()
            }
            .navigationTitle("Paramètres")
            
            Spacer()
            
            CustomButton(
                isPlaying: $isPlaying,
                hydrationActivationViewModel: hydrationActivationViewModel, selectedItems: $selectedItems, type: "Validate", selectedHour: $selectedHour
            )
        }
    }
}

#Preview {
    @Previewable @State var selectedItems : String = ""
    @Previewable @State var selectedHour : Int = 0
    TimerSettings(
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
            .disabled(test() == true)
            .padding()
        }
    }
    
    func test () -> Bool {
        if selectedHour == 0 || selectedItems.isEmpty {
            return true
        }
        return false
    }
}
