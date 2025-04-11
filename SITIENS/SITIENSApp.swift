//
//  SITIENSApp.swift
//  SITIENS
//
//  Created by Modibo on 07/04/2025.
//

import SwiftUI

@available(iOS 18.0, *)
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
                            HydrationActivation( )
                    }
                }
                
            }else {
                TabView{
                    HomeView(activeNavLink: $useNavLink)
                        
                    InfosView(activeNavLink: $useNavLink)
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
            }
        }
    }
}
