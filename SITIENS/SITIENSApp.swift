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
                            Chronograph()
                    }
                    
                    Tab(
                        "Hydradation",
                        systemImage: "drop.fill") {
                            WaterQuantityView(historyViewModel: HistoryViewModel())
                    }
                }
                
            }else {
                TabView{
                    HomeView(activeNavLink: $useNavLink, image: UIImage())
                        
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
