//
//  UserSettingsView.swift
//  SITIENS
//
//  Created by Modibo on 17/04/2025.
//

import SwiftUI

struct UserSettingsView: View {
    @State var profileType : [String] = ["Nourrissons","Femmes enceintes", "Personnes âgées","Sportifs","Enfants et adolescents","Travailleurs en environnement chaud","Personnes souffrant de maladies chroniques","Personnes en surpoids ou obèses","Voyageurs ou personnes en altitude","Personnes sous traitement médicamenteux"]
    @State var sizeOfGlace : [String] = ["SmallGlace","MediumGlace","LargeGlace"]
    @State var selectedProfileType : String = "nourrissons"
    @Binding var profil : String
    @Binding var glace : String
    @Environment(\.dismiss) var dismiss
    
    
//    
//    HStack{
//        Image("SmallGlace")
//            .resizable()
//            .frame(width: 40, height: 40, alignment: .center)
//        Image("MediumGlace")
//            .resizable()
//            .frame(width: 40, height: 40, alignment: .center)
//        Image("LargeGlace")
//            .resizable()
//            .frame(width: 40, height: 40, alignment: .center)
//    }
//}
    var body: some View {
        VStack {
            List {
                Picker("Profile", selection: $profil) {
                    ForEach(profileType,id: \.self) { profile in
                        Text(profile)
                    }
                }
                .pickerStyle(.inline)
              
                Picker("Taille de bouteille", selection: $glace) {
                    ForEach(sizeOfGlace,id: \.self) { profile in
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
