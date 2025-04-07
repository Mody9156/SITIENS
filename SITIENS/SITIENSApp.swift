//
//  SITIENSApp.swift
//  SITIENS
//
//  Created by Modibo on 07/04/2025.
//

import SwiftUI

@main
struct SITIENSApp: App {
    var body: some Scene {
        WindowGroup {
            TabView{
                HomeView()
                    
                InfosView()
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            
        }
    }
}
