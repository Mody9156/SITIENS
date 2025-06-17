//
//  ContentView.swift
//  SITIENS
//
//  Created by Modibo on 07/04/2025.
//

import SwiftUI
import Combine
// MARK: - HomeView : Vue d'accueil avec contenu informatif sur l'hydratation
struct HomeView: View {
    @State private var activeBool : Bool = false
    @Binding var hasSeenIntro : Bool
    
    var moreText : String {
        return   """
        Notre organisme est composé de 60 à 65 % d’eau. Et c’est précisément cette eau présente dans notre corps qui permet d’assurer de nombreuses fonctions vitales de notre corps. On comprend alors pourquoi il est si important de boire régulièrement et en quantité suffisante pour maintenir notre corps de nombreuses fonctions vitales.
        
        Il est généralement conseillé de boire entre 1,3 litre et 2 litres d’eau par jour. Tout dépend de son poids et de son niveau d’activité dans la journée. Mais dans tous les cas, si un organisme perd plus de 15 % de son poids en eau, le pronostic vital est alors engagé.
        
        Tout au long de la journée, notre corps perd en moyenne 2,6 litres d’eau, sous forme de transpiration, urines, respiration, larmes. Et pour compenser cette perte, il est recommandé de compenser cette perte hydrique par la boisson et la nourriture.
        
        Lorsque nous consommons des aliments riches en eau comme les fruits et les légumes, nous apportons environ 1 litre d’eau à notre organisme.
        Le métabolisme des nutriments produit quant à lui environ 30 cl d’eau endogène.
        Il faut donc apporter le reste en eau de boisson.
        
        Mais attention à ne pas attendre d’avoir soif pour boire ! Car même si la soif permet de compenser les pertes hydriques de l’organisme, la sensation de soif indique que la déshydratation est déjà amorcée. Il faut donc penser à boire régulièrement au fil de la journée, sachant qu’une quantité de 1,5 litre correspond environ à 8 verres d’eau. L’idéal est de boire souvent et en petites quantités.
        """
    }
    
    var body: some View {
        NavigationStack {
            ZStack{
                
                Image("Water")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .ignoresSafeArea()
                    .scaledToFill()
                
                VStack (spacing: 20){
                    
                    Spacer()
                    
                    VStack {
                        Text("Pour votre bien-être mental, commencez par comprendre l'impact de l'eau sur votre santé.")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.black.opacity(0.5), Color.clear]),
                                    startPoint: .bottom,
                                    endPoint: .top
                                )
                            )
                            .cornerRadius(12)
                        
                        //
                        
                        // MARK: - Bloc de texte + bouton "Lire plus"
                        ScrollView {
                            Text("""
                                                                 Notre organisme est composé de 60 à 65 % d’eau. Et c’est précisément cette eau présente dans notre corps qui permet d’assurer de nombreuses fonctions vitales de notre corps. On comprend alors pourquoi il est si important de boire régulièrement et en quantité suffisante pour maintenir notre corps de nombreuses fonctions vitales...
                                                                 """)
                            .font(.body)
                            .background(Color.gray.opacity(0.05))
                            .cornerRadius(8)
                            .padding()
                            //
                            Button {
                                withAnimation {
                                    activeBool.toggle()
                                }
                            } label: {
                                Label("Lire plus", systemImage: "chevron.down.circle")
                                    .font(.headline)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(16)
                            }
                            .padding(.horizontal)
                            .accessibilityLabel("Lire plus")
                            .accessibilityHint("Affiche plus d'informations sur l'impact de l'eau")
                            
                            // MARK: - Feuille modale avec le texte complet
                          
                        }
                        Spacer()
                    }
                    
                }
            }
            .toolbar {
                // MARK: - Image principale en forme de cercle
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        withAnimation {
                            hasSeenIntro = true
                        }
                    }) {
                        Text("Ignorer")
                            .padding(.horizontal)
                            .padding(.vertical, 6)
                            .background(Color.white.opacity(0.2))
                            .clipShape(Capsule())
                    }
                    .accessibilityLabel("Passer l’introduction")
                    
                }
                
            }
            .sheet(isPresented: $activeBool) {
                SheetView()
            }
        }
    }
    
    // MARK: - Fonction pour fermer la feuille modale
    func dissMiss(){
        activeBool = false
    }
    
    @ViewBuilder
    func SheetView() -> some View {
        ZStack {
            Color.white.opacity(0.95).ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Spacer()
                    Button(action: {
                        activeBool = false
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .padding(10)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }
                    .accessibilityLabel("Fermer")
                    .accessibilityHint("Ferme la feuille d'information")
                }
                ScrollView {
                    Text(moreText)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                }
            }
            Spacer()
        }
        .padding()
    }
}

// MARK: - Preview
#Preview {
    @Previewable @State var activeNavLink: Bool = true
    HomeView(hasSeenIntro: $activeNavLink)
    
}

