//
//  BouttonStopAndStart.swift
//  AppClip
//
//  Created by Modibo on 02/08/2025.
//

import SwiftUI

struct BouttonStopAndStart: View {
    var body: some View {
        Button {
            
        } label: {
            ZStack {
                Circle()
                    .fill(.gray)
                    .frame(width: 13, height: 13)
                    .shadow(radius: 10)
                
                Circle()
                    .fill(.white)
                    .frame(width: 125, height: 125)
                    .shadow(radius: 10)
                
                Circle()
                    .fill(.gray)
                    .frame(width: 120, height: 120)
                    .shadow(radius: 10)
                
                Text("Réinitialiser")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
        }
        .buttonStyle(.plain)
        .padding()
        .accessibilityLabel("Bouton Réinitialiser")
        .accessibilityHint("Remet à zéro le minuteur")
        .accessibilityAddTraits(.isButton)
    }
}

#Preview {
    BouttonStopAndStart()
}
