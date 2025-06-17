//
//  ContentView.swift
//  SITIENS
//
//  Created by Modibo on 07/04/2025.
//
import SwiftUI

// MARK: - HomeView : Vue d'accueil sur l'hydratation
struct HomeView: View {
    @State private var showSheet: Bool = false
    @Binding var hasSeenIntro: Bool
    @Environment(\.dismiss) var dismiss

    private var moreText: String {
        """
        Notre organisme est composé de 60 à 65 % d’eau. Cette eau permet d’assurer de nombreuses fonctions vitales du corps. Il est donc crucial de boire régulièrement et en quantité suffisante.

        On recommande de boire entre 1,3 L et 2 L par jour, selon le poids et l’activité. Une perte de plus de 15 % du poids en eau met en jeu le pronostic vital.

        Chaque jour, nous perdons environ 2,6 L d’eau (urines, transpiration, respiration...). En consommant fruits et légumes, nous récupérons 1 L, et 30 cl sont produits par le métabolisme. Il reste donc à boire environ 1,5 L — soit 8 verres d’eau.

        N’attendez pas d’avoir soif : buvez régulièrement en petites quantités pour rester bien hydraté.
        """
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Dégradé de fond
                LinearGradient(
                    gradient: Gradient(colors: [.blue.opacity(0.3), .cyan.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 24) {
                    Spacer()

                    // Image circulaire
                    Image("picture3")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 280, height: 280)
                        .clipShape(Circle())
                        .shadow(color: .gray.opacity(0.3), radius: 12, x: 0, y: 6)

                    VStack(alignment: .center, spacing: 16) {
                        Text("💧 Comprendre l’impact de l’eau sur votre santé mentale et physique")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(Color.white.opacity(0.15))
                            .cornerRadius(12)

                        Text("Notre organisme est composé de 60 à 65 % d’eau. Cette eau assure de nombreuses fonctions vitales...")
                            .font(.body)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .padding()
                            .background(Color.black.opacity(0.2))
                            .cornerRadius(12)

                        Button(action: {
                            withAnimation { showSheet = true }
                        }) {
                            Label("Lire plus", systemImage: "chevron.down.circle")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white.opacity(0.9))
                                .foregroundColor(.blue)
                                .cornerRadius(16)
                        }
                        .padding(.horizontal)
                        .accessibilityLabel("Lire plus")
                        .accessibilityHint("Affiche plus d'informations sur l'impact de l'eau")
                    }

                    Spacer()
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        withAnimation {
                            hasSeenIntro = true
                        }
                    }) {
                        Text("Ignorer")
                            .fontWeight(.semibold)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.white.opacity(0.25))
                            .foregroundColor(.black)
                            .clipShape(Capsule())
                    }
                    .accessibilityLabel("Ignorer l’introduction")
                }
            }
            .sheet(isPresented: $showSheet) {
                MoreInfoSheet(content: moreText) {
                    showSheet = false
                }
            }
        }
    }
}

// MARK: - Vue de la feuille modale
struct MoreInfoSheet: View {
    let content: String
    let dismissAction: () -> Void

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(content)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.black)
                        .padding()
                }
                .padding(.top)
            }
            .navigationTitle("Pourquoi s'hydrater ?")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: dismissAction) {
                        Image(systemName: "xmark")
                            .imageScale(.medium)
                            .foregroundColor(.black)
                            .padding(8)
                            .background(Color.gray.opacity(0.3))
                            .clipShape(Circle())
                    }
                    .accessibilityLabel("Fermer")
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    HomeView(hasSeenIntro: .constant(false))
}
