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
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action:{
                            activeNavLink = true
                        }){
                            Text("Skip")
                                .foregroundStyle(.white)
                                .font(.headline)
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                    Image(systemName: "waterbottle.fill")
                        .resizable()
                        .frame(width: 100, height: 150)
                        .foregroundStyle(.white)
                    
                    Text("Combien d’eau faut-il boire en moyenne chaque jour ?")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Text("Notre organisme est composé de 60 à 65 % d’eau. Et c’est précisément cette eau présente dans notre corps qui permet d’assurer de nombreuses fonctions vitales de notre corps. On comprend alors pourquoi il est si important de boire régulièrement et en quantité suffisante pour maintenir notre corps en bonne santé.")
                        .font(.callout)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Spacer()
                }
            }
        }
    }
}

//#Preview {
//    struct Active: View {
//        @State var activeNavLink: Bool = false
//           
//           var body: some View {
//               HomeView(activeNavLink: $activeNavLink)
//           }
//       }
//    Active()
//    
//}
