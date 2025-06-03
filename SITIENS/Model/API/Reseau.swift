//
//  Reseau.swift
//  SITIENS
//
//  Created by Modibo on 02/06/2025.
//

import Foundation

struct Reseau : Identifiable,Decodable {
    var id : String {code}
    let code: String
    let nom: String
    let debit: String
}

struct AnalyseEau : Identifiable, Decodable{
    var id: String { code_prelevement }
    let code_departement: String
    let nom_departement: String
    let code_prelevement: String
    let code_parametre: String
    let code_parametre_se: String
    let code_parametre_cas: String
    let libelle_parametre: String
    let libelle_parametre_maj: String
    let libelle_parametre_web: String?
    let code_type_parametre: String
    let code_lieu_analyse: String
    let resultat_alphanumerique: String
    let resultat_numerique: Double?
    let libelle_unite: String
    let code_unite: String
    let limite_qualite_parametre: String
    let reference_qualite_parametre: String?
    let code_commune: String
    let nom_commune: String
    let nom_uge: String
    let nom_distributeur: String
    let nom_moa: String
    let date_prelevement: String  // Tu peux convertir en Date si besoin
    let conclusion_conformite_prelevement: String
    let conformite_limites_bact_prelevement: String
    let conformite_limites_pc_prelevement: String
    let conformite_references_bact_prelevement: String
    let conformite_references_pc_prelevement: String
    let reference_analyse: String
    let code_installation_amont: String
    let nom_installation_amont: String
    
    let reseaux: [Reseau]
}

struct AnalyseEauResponse: Decodable {
    let data: [AnalyseEau]
}
