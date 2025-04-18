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
    
    var body: some View {
        VStack {
            List {
                Picker("Profile", selection: $selectedProfileType) {
                    ForEach(profileType,id: \.self) { profile in
                        Text(profile)
                    }
                }
                .pickerStyle(.inline)
            }
            
            Text("Profil")
            
        }
    }
}

#Preview {
    UserSettingsView()
}
