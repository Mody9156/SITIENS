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
                        "Chronomètre",
                        systemImage: "stopwatch") {
                            HydrationActivation( )
                    }
                    
                    Tab(
                        "Chronomètre",
                        systemImage: "stopwatch") {
                            WaterQuantityView()
                    }
                }
                
            }else {
                TabView{
                    HomeView(activeNavLink: $useNavLink)
                        
                    InfosView(activeNavLink: $useNavLink)
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .background(Color(.gray).opacity(0.3).ignoresSafeArea())
                .onAppear{
                    UIPageControl.appearance().pageIndicatorTintColor = .gray
                    UIPageControl.appearance().currentPageIndicatorTintColor = .black
                }
                
            }
        }
        
    }
}
