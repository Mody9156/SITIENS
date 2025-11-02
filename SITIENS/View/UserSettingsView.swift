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
    @State var isActive : Bool = false
    @State var isActiveForGlace : Bool = false
    @State var selectedSound: String? = nil
    @State var selectedGlace: String? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.blue.opacity(0.3), .cyan.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    VStack (alignment: .leading, spacing: 12){
                        Text("Sélectionner un profile")
                            .font(.headline)
                            .font(.largeTitle)
                        
                        CustomPicker(
                            type: $profileType,
                            isActive: $isActive,
                            selectedSound: $selectedSound
                        )
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .shadow(radius: 5)
                    
                    VStack (alignment: .leading, spacing: 12){
                        Text("Sélectionner un récipient")
                            .font(.headline)
                            .font(.largeTitle)

                        CustomPicker(
                            type: $sizeOfGlace,
                            isActive: $isActiveForGlace,
                            selectedSound: $selectedGlace
                        )
                        
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .shadow(radius: 5)
                    
                    Spacer()
                    
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
                    .disabled(profil.isEmpty || glace.isEmpty)
                    .padding()
                    .accessibilityLabel("Bouton Valider")
                    .accessibilityHint("Valide vos préférences de profil et de récipient")
                    .accessibilityAddTraits(.isButton)
                }
                .padding()
                .navigationTitle("Paramètres")
            }
        }
    }
}

#Preview {
    @Previewable @State var profilType : String = ""
    @Previewable @State var glace : String = ""
    UserSettingsView(profil: $profilType, glace: $glace)
}

struct CustomPicker: View {
    @Binding var type : [String]
    @Binding var isActive : Bool
    @Binding var selectedSound: String?
    
    var body: some View {
       
        Button {
            isActive.toggle()
        } label: {
            HStack {
                Text("Sélectionner")
                    .foregroundColor(Color("TextBackground"))
                    .padding()
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(Color("TextBackground"))
                    .padding()
                
                
                Text(selectedSound ?? "")
                    .foregroundColor(Color("TextBackground"))
                    .padding()
            }
            .background(.gray.opacity(0.7))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray, lineWidth: 1)
            )
            .accessibilityLabel("Sélectionner un son")
            .accessibilityHint("Double-cliquez pour choisir un audio")
        }
        .navigationDestination(isPresented: $isActive) {
            ChoosElement(sound: $type, selectedSound: $selectedSound)
        }
//        
//        Picker(
//            selection: $name,
//            label:
//                HStack{
//                    Text(name.isEmpty ? "Seclectionner":name)
//                        .foregroundStyle(name.isEmpty ? .gray:.gray)
//                        .lineLimit(1)
//                    
//                    Spacer()
//                    Image(systemName: "chevron.right")
//                        .foregroundColor(.gray)
//                }
//        ) {
//            ForEach(type,id: \.self) { profile in
//                Text(profile)
//                    .lineLimit(1)
//            }
//        }
//        .pickerStyle(.navigationLink)
//        .padding()
//        .background(.ultraThinMaterial)
//        .cornerRadius(12)
//        .overlay(
//            RoundedRectangle(cornerRadius: 12)
//                .stroke(Color.gray.opacity(0.15), lineWidth: 1)
//        )
//        .accessibilityLabel(name)
//        .accessibilityHint("Appuyez pour choisir une \(name.lowercased())")
       
    }
}





struct ChoosElement: View {
    @Binding var sound : [String]
    @Binding var selectedSound: String?
    
    var body : some View {
        
        List(sound,id:\.self) { items in
            HStack {
                Image(systemName: "checkmark")
                    .foregroundStyle(.yellow)
                    .opacity(selectedSound == items ? 1 : 0)
                Button {
                    if selectedSound == items {
                        selectedSound = nil
                    }else {
                        selectedSound = items
                       
                    }
                    
                } label: {
                    
                    Text(items)
                        .foregroundStyle(.black)
                }
            }
        }
    }
}
