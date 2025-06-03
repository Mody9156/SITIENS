//
//  SITIENSApp.swift
//  SITIENS
//
//  Created by Modibo on 07/04/2025.
//

import SwiftUI
import CoreData
@main
struct SITIENSApp: App {
    @State var useNavLink : Bool = false
    let analyseEau: AnalyseEau =
        AnalyseEau(
            code_prelevement: "75",
            code_parametre: "Paris",
            code_parametre_se: "PREL123",
            code_parametre_cas: "PARAM001",
            code_unite: "SE001",
            code_departement: "91", // ou "CAS001" si présent
            code_type_parametre: "Nitrates",
            code_lieu_analyse: "NITRATES",
            code_commune: "Nitrates dans l'eau",
            code_installation_amont: "CHIM",
            libelle_parametre: "LIEU001",
            libelle_parametre_maj: "10",
            libelle_parametre_web: "10.5",
            libelle_unite: "mg/L",
            resultat_alphanumerique: "MG_L",
            resultat_numerique: 50,
            limite_qualite_parametre: nil,
            reference_qualite_parametre: "75056",
            reference_analyse: "Paris",
            nom_departement: "UGE PARIS",
            nom_commune: "Eau de Paris",
            nom_uge: "MOA Paris",
            nom_distributeur: "2024-05-20",
            nom_moa: "Conforme",
            nom_installation_amont: "Conforme",
            date_prelevement: "Conforme",
            conclusion_conformite_prelevement: "Conforme",
            conformite_limites_bact_prelevement: "Conforme",
            conformite_limites_pc_prelevement: "REF123456",
            conformite_references_bact_prelevement: "INST001",
            conformite_references_pc_prelevement: "Station Paris Nord",
            reseaux: [
                Reseau(code: "R001", nom: "Réseau principal", debit: "15 m3/s")
            ]
        )
    
    var body: some Scene {
        WindowGroup {
            if useNavLink {
                TabView {
                    Tab(
                        "Chronomètre",
                        systemImage: "stopwatch") {
                            Chronograph()
                    }
                    
                    Tab(
                        "Hydradation",
                        systemImage: "drop.fill") {
                            WaterQuantityView(
                                historyViewModel: HistoryViewModel()
                            )
                    }
                    
                    Tab(
                        "Carte"
                         ,systemImage: "map"){
                             MapView(
                                waterAPIViewModel: WaterAPIViewModel(),
                                analyseEau: analyseEau
                             )
                       }
                    
                }
                
            }else {
                TabView{
                    HomeView(activeNavLink: $useNavLink)
                        
                    InformationView(activeNavLink: $useNavLink)
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .background(  LinearGradient(
                    gradient: Gradient(colors: [.blue.opacity(0.3), .cyan.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                    .ignoresSafeArea())
                .onAppear{
                    UIPageControl.appearance().pageIndicatorTintColor = .gray
                    UIPageControl.appearance().currentPageIndicatorTintColor = .black
                }
                
            }
        }
        
    }
}
