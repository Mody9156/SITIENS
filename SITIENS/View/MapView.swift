//
//  MapView.swift
//  SITIENS
//
//  Created by Modibo on 02/06/2025.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @State var waterAPIViewModel : WaterAPIViewModel
    let analyseEau : AnalyseEau
    @State private var cityName = "Le Mas-d'Azil"
    var body: some View {
                  
        VStack {
                VStack {
                    
                    Map(
                        coordinateRegion: $waterAPIViewModel.region,
                        annotationItems: waterAPIViewModel.annotation != nil ? [waterAPIViewModel.annotation!] : []){ place in
                        MapMarker(coordinate: place.location, tint: .red)
                        
                    }
                    .frame(height: 400)
                }
                .onAppear{
                    let result = waterAPIViewModel
                    Task{
                      
                        result.geocode(city: analyseEau.nom_commune)
                        try await result.showLocation()
                    }
                }
        }
    }
    }
#Preview {
    let sampleAnalyseEau = AnalyseEau(
        code_prelevement: "75",
        code_parametre: "1101",
        code_parametre_se: "ALCL",
        code_parametre_cas: "15972-60-8",
        code_unite: "133",
        code_departement: "09",
        code_type_parametre: "N",
        code_lieu_analyse: "L",
        code_commune: "09181",
        code_installation_amont: "009001491",
        libelle_parametre: "Alachlore",
        libelle_parametre_maj: "ALACHLORE",
        libelle_parametre_web: nil,
        libelle_unite: "µg/L",
        resultat_alphanumerique: "<0,005",
        resultat_numerique: 0.0,
        limite_qualite_parametre: nil,
        reference_qualite_parametre: nil,
        reference_analyse: "00900159261",
        nom_departement: "Ariège",
        nom_commune: "Le Mas-d'Azil",
        nom_uge: "S.M.D.E.A",
        nom_distributeur: "S.M.D.E.A",
        nom_moa: "S.M.D.E.A",
        nom_installation_amont: "ROQUEBRUNE SMDEA ARIZE",
        date_prelevement: "2025-03-31T16:12:00Z",
        conclusion_conformite_prelevement: "Eau d'alimentation conforme.",
        conformite_limites_bact_prelevement: "C",
        conformite_limites_pc_prelevement: "C",
        conformite_references_bact_prelevement: "C",
        conformite_references_pc_prelevement: "C",
        reseaux: [
            Reseau(code: "009001443", nom: "SMDEA ARIZE", debit: "100 %")
        ]
    )

    MapView(
        waterAPIViewModel: WaterAPIViewModel(waterAPI: WaterAPI()),
        analyseEau: sampleAnalyseEau
    )
}
