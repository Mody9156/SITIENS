//
//  ContentView.swift
//  SITIENS
//
//  Created by Modibo on 07/04/2025.
//

import SwiftUI

struct HomeView: View {
    @Binding  var activeNavLink : Bool
    
    var body: some View {
        NavigationStack {
            ZStack{
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
                    
                    Image("Water")
                        .resizable()
                        .foregroundStyle(.red)
                    
                    ScrollView {
                        VStack(alignment: .leading){
                            Text("Combien d’eau faut-il boire en moyenne chaque jour ?")
                                .font(.title)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                                .padding()
                            
                            Text("Notre organisme est composé de 60 à 65 % d’eau. Et c’est précisément cette eau présente dans notre corps qui permet d’assurer de nombreuses fonctions vitales de notre corps. On comprend alors pourquoi il est si important de boire régulièrement et en quantité suffisante pour maintenir notre corps en bonne santé.")
                                .font(.callout)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var activeNavLink: Bool = false
    HomeView(activeNavLink: $activeNavLink)
    
}
