//
//  UserSettingsView.swift
//  SITIENS
//
//  Created by Modibo on 17/04/2025.
//

import SwiftUI

struct UserSettingsView: View {
    @State var profileType : [String] = ["nourrissons","femmes enceintes", "personnes âgées","sportifs"]
    @State var selectedProfileType : String = "nourrissons"
    @Binding var profil : String
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
            }
            
            
            Button {
                withAnimation {
                    if !profil.isEmpty {
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
        }
    }
}

#Preview {
    @Previewable @State var profilType : String = ""
    UserSettingsView(profil: $profilType)
}
