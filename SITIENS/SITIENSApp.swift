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
                            Chronograph()
                                .transition(.opacity)
                                .tabItem {
                                    Label(
                                        "Chronomètre",
                                        systemImage: "stopwatch"
                                    )
                                }
                    
                        WaterQuantityView(historyViewModel: HistoryViewModel())
                            .transition(.opacity)
                            .tabItem {
                                Label("Hydratation", systemImage: "drop.fill")
                                    
                            }
                            

                    }
                } else {
                    TabView {
                        HomeView(hasSeenIntro: $showMainApp)
                            .transition(.opacity)

                        InformationView(hasSeenIntro: $showMainApp)
                            .transition(.opacity)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    .background(Color.black)
                    .ignoresSafeArea()
                    .onAppear {
                        UIPageControl.appearance().pageIndicatorTintColor = .gray
                        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(named: "background") ?? .white
                    }
                }
            }
            .animation(.easeOut, value: showMainApp)
        }
    }
}
