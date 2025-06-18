//
//  InfosView.swift
//  SITIENS
//
//  Created by Modibo on 07/04/2025.
//
import SwiftUI

struct InformationView: View {
    @Binding var hasSeenIntro: Bool
    @State private var showSheet: Bool = false
    @State private var animateEmoji : Bool =  false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.blue.opacity(0.3), .cyan.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                    ZStack(alignment: .topTrailing) {
                        Button(action: {
                            withAnimation {
                                hasSeenIntro = true
                            }
                        }) {
                            Text("Ignorer")
                                .fontWeight(.semibold)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color.white.opacity(0.25))
                                .foregroundColor(.black)
                                .clipShape(Capsule())
                        }
                        .padding()
                        .accessibilityLabel("Ignorer l’introduction")
                        
                        VStack(spacing: 20) {
                            Spacer()
                            
                            Image("thirstyPicture")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 280, height: 280)
                                .clipShape(Circle())
                                .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
                            
                            Text("💧")
                                .font(.system(size: 40))
                                .scaleEffect(animateEmoji ? 1.2 : 1)
                                .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: animateEmoji)
                                .onAppear { animateEmoji = true }
                            
                            Text("💧 Boire de l’eau : quelle est la limite à ne pas dépasser ?")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(12)
                            
                            
                            VStack(alignment: .leading, spacing: 16) {
                                Text("""
                                    Il est fortement déconseillé de boire plus de 5 litres d’eau par jour. Une surconsommation peut entraîner une dilution des constantes sanguines et des conséquences graves...
                                    """)
                                .font(.body)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black.opacity(0.2))
                                .cornerRadius(12)
                                
                                Button {
                                    withAnimation {
                                        showSheet.toggle()
                                    }
                                } label: {
                                    Label("Lire plus", systemImage: "chevron.down.circle")
                                        .font(.headline)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(.white)
                                        .foregroundColor(.blue)
                                        .cornerRadius(16)
                                }
                                .padding(.horizontal)
                                .accessibilityLabel("Lire plus")
                            }
                            .padding(.horizontal)
                            
                            Spacer()
                        }
                        .padding()
                    }
                
            }
            .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//
//                }
            }
            .sheet(isPresented: $showSheet) {
                RoundedRectangle(cornerRadius: 3)
                    .frame(width: 40, height: 5)
                    .foregroundColor(.gray.opacity(0.4))
                    .padding(.top, 8)

                InfoDetailSheet(
                    sections: [
                        ("Insomnies et réveils nocturnes", moreText),
                        ("La potomanie : un trouble psychiatrique", potomanie),
                        ("Le coma hydrique : boire trop d’eau, trop vite", hydrique)
                    ],
                    dismissAction: { showSheet = false }
                )
            }
        }
    }

    // MARK: - Contenu à afficher dans la feuille
    private var moreText: String {
        """
        Si vous buvez trop d’eau avant de dormir, vous risquez de vous réveiller fréquemment. En effet, cela empêche la sécrétion de l’hormone antidiurétique nécessaire à un sommeil profond.
        """
    }

    private var potomanie: String {
        """
        La potomanie est un trouble psychiatrique caractérisé par une consommation excessive d’eau. Elle peut mener à de graves complications, dont un œdème cérébral ou un coma.
        """
    }

    private var hydrique: String {
        """
        Boire plus de 5 litres d’eau par jour peut entraîner un déséquilibre en sodium, provoquant une intoxication à l’eau, maux de tête, voire un coma potentiellement mortel.
        """
    }
}

// MARK: - Vue de feuille d'information
struct InfoDetailSheet: View {
    let sections: [(String, String)]
    let dismissAction: () -> Void

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    ForEach(sections, id: \.0) { title, text in
                        InfoSection(title: title, text: text)
                    }
                }
                .padding()
            }
            .navigationTitle("Les risques d’une surhydratation")
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
                }
            }
        }
    }
}

// MARK: - Composant réutilisable pour les sections
struct InfoSection: View {
    let title: String
    let text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)

            Text(text)
                .font(.body)
        }
    }
}

// MARK: - Preview
#Preview {
    @Previewable @State var seen = false
    return InformationView(hasSeenIntro: $seen)
}
