//
//  InfosView.swift
//  SITIENS
//
//  Created by Modibo on 07/04/2025.
//

import SwiftUI

struct InfosView: View {
    @Binding var activeNavLink: Bool
    
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
                            Text("Skip")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color.black)
                                .clipShape(Capsule())
                        }
                        .accessibilityLabel("Passer l’introduction")
                        
                    }
                    .padding()
                    
                    Image("thirstyPicture")
                        .resizable()
                        .frame(height: 480)
                    
                    ScrollView {
                        VStack(alignment: .leading) {
                            Text("Boire de l’eau : quelle est la limite à ne pas dépasser ?")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 8)
                            
                            Text("""
                                D’une manière générale, il est fortement déconseillé de boire plus de 5 litres d’eau par jour, \
                                car une grande quantité d’eau risque de diluer les constantes sanguines. Voyons quelles peuvent \
                                être les différentes conséquences d’une surconsommation d’eau.
                                """)
                            .font(.callout)
                            .multilineTextAlignment(.leading)
                            .frame(width: 300, alignment: .leading)
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
    InfosView(activeNavLink: $activeNavLink)
}
