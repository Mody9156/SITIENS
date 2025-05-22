//
//  ContentView.swift
//  SITIENS
//
//  Created by Modibo on 07/04/2025.
//

import SwiftUI
import Combine

struct HomeView: View {
    @Binding  var activeNavLink : Bool
    //    let imageProcessor = ImageProcessor()
    let image : UIImage
    
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
                    ZStack {
                        
                        Image("Water")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 350,height: 350)
                            .clipShape(Circle())
                            .shadow(color: .white, radius: 15)
                    }

                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Combien d’eau faut-il boire en moyenne chaque jour ?")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)

                            Text("Notre organisme est composé de 60 à 65 % d’eau. Et c’est précisément cette eau présente dans notre corps qui permet d’assurer de nombreuses fonctions vitales de notre corps. On comprend alors pourquoi il est si important de boire régulièrement et en quantité suffisante pour maintenir notre corps en bonne santé.")
                                .font(.body)
                                .multilineTextAlignment(.leading)
                        }
                        .padding()
                    }
                }

                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            withAnimation {
                                activeNavLink = true
                            }
                        }) {
                            Text("Skip")
                                .font(.headline)
                                .foregroundStyle(.black)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color.white)
                                .clipShape(Capsule())
                                .padding()
                        }
                        .accessibilityLabel("Passer l’introduction")
                        
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var activeNavLink: Bool = false
    HomeView(activeNavLink: $activeNavLink, image: UIImage())
    
}
