//
//  SITIENSApp.swift
//  SITIENS
//
//  Created by Modibo on 07/04/2025.
//

import SwiftUI
import CoreData
import Combine

@main
struct SITIENSApp: App {
    @State var showMainApp: Bool = false

    var body: some Scene {
        WindowGroup {
            Group {
                if showMainApp {
                    TabView {
                        Tab("Chronomètre", systemImage: "stopwatch") {
                            Chronograph()
                                .transition(.opacity)
                        }
                        
                        Tab("Hydratation", systemImage: "drop.fill") {
                            WaterQuantityView(historyViewModel: HistoryViewModel())
                                .transition(.opacity)
                        }
                    }
                    
                } else {
                    TabView {
                       
                        Tab("Hydratation", systemImage: "drop.fill") {
                            HomeView(hasSeenIntro: $showMainApp)
                                .transition(.opacity)
                        }
                        
                        Tab("Hydratation", systemImage: "drop.fill") {
                            InformationView(hasSeenIntro: $showMainApp)
                                .transition(.opacity)
                        }
                            
                    }
                    .background(Color.black)
                    .ignoresSafeArea()
                    .onAppear {
                        UIPageControl.appearance().pageIndicatorTintColor = .gray
                        UIPageControl
                            .appearance().currentPageIndicatorTintColor = UIColor(
                                named: "BackgroundColor"
                            )
                    }
                }
            }
            .animation(.easeOut, value: showMainApp)
        }
    }
}
