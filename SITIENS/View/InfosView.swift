//
//  InfosView.swift
//  SITIENS
//
//  Created by Modibo on 07/04/2025.
//

import SwiftUI

struct InfosView: View {
    var body: some View {
        ZStack{
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                Image(systemName: "waterbottle.fill")
                    .resizable()
                    .frame(width: 100,height: 200)
                    .foregroundStyle(.white)
                
                Text("Boire de l’eau : quelle est la limite à ne pas dépasser ?")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .padding()
                
                Text("D’une manière générale, il est fortement déconseillé de boire plus de 5 litres d’eau par jour, car une grande quantité d’eau risque de diluer les constantes sanguines. Voyons quelles peuvent être les différentes conséquences d’une surconsommation d’eau.")
                    .font(.callout)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(width: 300)
                
                Spacer()
                
            }
        }
    }
}

#Preview {
    InfosView()
}
