//
//  SITIENSApp.swift
//  SITIENS
//
//  Created by Modibo on 07/04/2025.
//

import SwiftUI

@main
struct SITIENSApp: App {
    @State var useNavLink : Bool = false 
    
    var body: some Scene {
        WindowGroup {
            if useNavLink {
                TabView {
                    Tab(
                        "Home",
                        systemImage: "house.fill") {
                            hydrationActivation(
                                hydrationActivationViewModel: HydrationActivationViewModel()
                            )
                    }
                }
                
            }else {
                TabView{
                    HomeView(activeNavLink: $useNavLink)
                        
                    InfosView()
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
            }
        }
    }
}
