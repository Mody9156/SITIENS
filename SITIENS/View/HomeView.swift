//
//  ContentView.swift
//  SITIENS
//
//  Created by Modibo on 07/04/2025.
//

import SwiftUI

struct HomeView: View {
    @State private var activeBool : Bool = false
    @Binding  var activeNavLink : Bool
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
                // Background
                LinearGradient(
                    gradient: Gradient(colors: [.blue.opacity(0.3), .cyan.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack {
                    HStack{
                        
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
                    
                  
                    
                    ZStack (alignment: .topTrailing){
                        
                        Image("Water")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 350)
                            .shadow(radius: 5)
                            .clipShape(Circle())
                            .offset(y:-100)
                        
                        ScrollView()
                    }
                }
            }
        }
    }
    func dissMiss(){
        activeBool = false
    }
}

#Preview {
    @Previewable @State var activeNavLink: Bool = false
    HomeView(activeNavLink: $activeNavLink)
    
}


struct ScrollView: View {
    var body: some View {
        ScrollView {
            Text("Combien d’eau faut-il boire en moyenne chaque jour ?")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding(.leading)
                .padding(.trailing)
                .padding(.top)
            Text("""
Notre organisme est composé de 60 à 65 % d’eau. Et c’est précisément cette eau présente dans notre corps qui permet d’assurer de nombreuses fonctions vitales de notre corps. On comprend alors pourquoi il est si important de boire régulièrement et en quantité suffisante pour maintenir notre corps de nombreuses fonctions vitales...

""")
            .font(.body)
            .background(Color.gray.opacity(0.05))
            .cornerRadius(8)
            .padding(.leading)
            .padding(.trailing)
            .padding(.top)
            
            Button {
                withAnimation {
                    activeBool.toggle()
                }
            } label: {
                Text("Lire plus")
                    .fontWeight(.medium)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
            }
            .accessibilityLabel("Lire plus sur l’hydratation")
            .accessibilityHint("Ouvre une fenêtre avec plus d’informations")
            .sheet(isPresented: $activeBool) {
                ScrollView {
                    ZStack {
                        LinearGradient(
                            gradient: Gradient(colors: [.blue.opacity(0.3), .cyan.opacity(0.2)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .ignoresSafeArea()
                        
                        VStack(alignment: .center, spacing: 16) {
                            Text(moreText)
                                .font(.body)
                                .multilineTextAlignment(.leading)
                            
                            Button("x") {
                                dissMiss()
                            }
                            .fontWeight(.medium)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                            .accessibilityLabel("Fermer la page")
                            .accessibilityHint("Fermer une fenêtre avec plus d’informations")
                        }
                        .padding()
                    }
                }
            }
        }
    }
}
