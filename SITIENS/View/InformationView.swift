//
//  InfosView.swift
//  SITIENS
//
//  Created by Modibo on 07/04/2025.
//

import SwiftUI

struct InformationView: View {
    @Binding var activeNavLink: Bool
    @State private var activeBool : Bool = false
    
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
                
                VStack {
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                activeNavLink = true
                            }
                            
                        }) {
                            Text("Ignorer")
                                .font(.headline)
                                .foregroundStyle(.black)
                                .padding()
                                .background(Color.white)
                                .clipShape(Capsule())
                        }
                        .accessibilityLabel("Passer l’introduction")
                        
                    }
                    .padding()
                    
                    Image("thirstyPicture")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 350, height: 350)
                        .clipShape(Circle())
//                        .overlay(Circle().stroke(Color.black, lineWidth: 4))
                        .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
                    
                    ScrollView {
                        VStack(alignment: .center) {
                            Text("Boire de l’eau : quelle est la limite à ne pas dépasser ?")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                            
                            Text("""
                                D’une manière générale, il est fortement déconseillé de boire plus de 5 litres d’eau par jour, \
                                car une grande quantité d’eau risque de diluer les constantes sanguines. Voyons quelles peuvent \
                                être les différentes conséquences d’une surconsommation d’eau.
                                """)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            
                            Button {
                                withAnimation {
                                    activeBool.toggle()
                                }
                                
                            } label: {
                                Text( activeBool ?  "Réduire" : "Plus")
                                    .fontWeight(.medium)
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 8)
                                            .background(Color.blue.opacity(0.1))
                                            .cornerRadius(8)
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var activeNavLink: Bool = false
    InformationView(activeNavLink: $activeNavLink)
}
