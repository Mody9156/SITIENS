//
//  UserSettingsView.swift
//  SITIENS
//
//  Created by Modibo on 17/04/2025.
//

import SwiftUI

struct UserSettingsView: View {
    @State var profileType : [String] = ["nourrissons","femmes enceintes", "personnes âgées","sportifs"]
    
    var body: some View {
        VStack {
            Text("Profil")
            
        }
    }
}

#Preview {
    UserSettingsView()
}
