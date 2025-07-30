//
//  UserSettingsView.swift
//  SITIENS
//
//  Created by Modibo on 17/04/2025.
//

import SwiftUI

struct UserSettingsView: View {
    @State var profileType : [String] = ["Nourrissons","Femmes enceintes", "Personnes âgées","Sportifs","Enfants et adolescents","Travailleurs en environnement chaud","Personnes souffrant de maladies chroniques","Personnes en surpoids ou obèses","Voyageurs ou personnes en altitude","Personnes sous traitement médicamenteux"]
    @State var sizeOfGlace : [String] = ["Petit – 200 ml","Moyen – 300 ml",  "Grand – 500 ml"]
    @State var selectedProfileType : String = "nourrissons"
    @Binding var profil : String
    @Binding var glace : String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            List {
                Picker("Profile", selection: $profil) {
                    ForEach(profileType,id: \.self) { profile in
                        Text(profile)
                    }
                }
                .pickerStyle(.inline)
                
                Picker("Type de récipient", selection: $glace) {
                    ForEach(sizeOfGlace,id: \.self) { profile in
                        Text(profile)
                    }
                }
                .pickerStyle(.inline)
                
            }
            
            Button {
                withAnimation {
                    if !profil.isEmpty && !glace.isEmpty{
                        dismiss()
                    }
                }
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 50)
                    Text("Valider")
                        .foregroundStyle(.white)
                }
            }
            .disabled(profil.isEmpty)
            .padding()
            .accessibilityLabel("Bouton Valider")
            .accessibilityHint("Valide vos préférences de profil et de récipient")
            .accessibilityAddTraits(.isButton)
        }
    }
}

#Preview {
    @Previewable @State var profilType : String = ""
    @Previewable @State var glace : String = ""
    UserSettingsView(profil: $profilType, glace: $glace)
}
