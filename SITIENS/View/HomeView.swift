//
//  ContentView.swift
//  SITIENS
//
//  Created by Modibo on 07/04/2025.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("navlink") var activeNavLink : Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        NavigationLink {
                            Timer()
                        } label: {
                            Button(action:{
                                activeNavLink = true
                            }){
                                Text("Skip")
                                    .foregroundStyle(.white)
                                    .font(.headline)
                            }
                        }

                     
                        
                    }
                    .padding()
                    
                    Spacer()
                    
                    Image(systemName: "waterbottle.fill")
                        .resizable()
                        .frame(width: 100,height: 200)
                        .foregroundStyle(.white)
                    
                    Text("Combien d’eau faut-il boire en moyenne chaque jour ?")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .padding()
                    
                    Text("Notre organisme est composé de 60 à 65 % d’eau. Et c’est précisément cette eau présente dans notre corps qui permet d’assurer de nombreuses fonctions vitales de notre corps. On comprend alors pourquoi il est si important de boire régulièrement et en quantité suffisante pour maintenir notre corps en bonne santé.")
                        .font(.callout)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(width: 300)
                    
                    Spacer()
                    
                    
                    
                    
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
