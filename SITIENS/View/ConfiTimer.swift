//
//  ConfigureTimer.swift
//  SITIENS
//
//  Created by Modibo on 10/04/2025.
//

import SwiftUI
import UIKit

struct ConfiTimer: View {
    @State var sound : [String] = ["asphalt-sizzle","clover-feast","fresh-breeze"]
    @State var hour : [Int] = [3600,7200,10800]
    @Binding var selectedItems : String
    @Binding var selectedHour : Int
    @Environment(\.dismiss) var dismiss
    @Bindable var hydrationActivationViewModel : HydrationActivationViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                LinearGradient(
                    gradient: Gradient(colors: [.blue.opacity(0.3), .cyan.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack (spacing: 30){
                        Text("Configuration")
                            .font(.largeTitle.bold())
                            .foregroundStyle(.blue)
                            .multilineTextAlignment(.center)
                            .padding(.top)
                        
                        Spacer()
                        
                        VStack {
                            Text("Sélectionner Un temps d'hydratation")
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            Picker("", selection: $selectedHour) {
                                ForEach(hour,id: \.self) {
                                    Text("\(hydrationActivationViewModel.formatTimer($0))")
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
                        
                        Spacer()
                        
                        Button {
                            let generator = UIImpactFeedbackGenerator(style: .medium)
                            generator.impactOccurred()
                            dismiss()
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
                        .padding(.bottom)
                    }
                    .padding()
                }
            }
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
    .padding()
    
}
