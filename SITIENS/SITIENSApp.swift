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
    @State var showMainApp : Bool = false
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                Group {
                if showMainApp {
                    TabView {
                        Tab(
                            "Chronomètre",
                            systemImage: "stopwatch") {
                                Chronograph()
                                    .transition(.opacity)
                            }
                        
                        Tab(
                            "Hydradation",
                            systemImage: "drop.fill") {
                                WaterQuantityView(
                                    historyViewModel: HistoryViewModel()
                                )
                                .transition(.opacity)
                            }
                        
                        //                    Tab(
                        //                        "Carte"
                        //                         ,systemImage: "map"){
                        //                             MapView(
                        //                                waterAPIViewModel: WaterAPIViewModel()
                        //                             )
                        //                       }
                    }
                    
                }else {
                    TabView{
                        HomeView(hasSeenIntro: $showMainApp)
                            .transition(.opacity)
                        InformationView(activeNavLink: $showMainApp)
                            .transition(.opacity)
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
                        print("showMainApp :\(showMainApp) ")
                    }
                }
            }
                .animation(.easeOut,value: showMainApp)
        }
        }
    }
}
