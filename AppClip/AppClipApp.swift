//
//  AppClipApp.swift
//  AppClip
//
//  Created by Modibo on 01/08/2025.
//

import SwiftUI

@main
struct AppClipApp: App {
    @State private var hasSeenIntro: Bool = false
    var body: some Scene {
      
        WindowGroup {
            Group {
                if hasSeenIntro {
                    TabView {
                        ChronographToAppClip()
                            .transition(.opacity)
                            .transition(.opacity)
                            .tabItem {
                                Label(
                                    "Chronomètre",
                                    systemImage: "stopwatch"
                                )
                            }
                        
                        WaterQuantityViewToAppClip()
                            .transition(.opacity)
                            .tabItem {
                                Label("Hydratation", systemImage: "drop.fill")
                            }

                    }
                } else {
                    TabView {
                        AppClipHomeView(hasSeenIntro: $hasSeenIntro)
                            .transition(.opacity)
                        
                        InformationViewToAppClip
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
            .animation(.easeOut, value: hasSeenIntro)
        }
    }
}
