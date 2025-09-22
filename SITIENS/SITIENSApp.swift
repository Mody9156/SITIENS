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
    @State private var hydrationActivationViewModel = HydrationActivationViewModel()
    @SceneStorage("selectedTab") var selectedTab = 0
    
    var body: some Scene {
        WindowGroup {
            Group {
                if showMainApp {
                    TabView {
                        
                        Tab("Chronomètre", systemImage : "stopwatch") {
                            Chronograph(hydrationActivationViewModel: hydrationActivationViewModel)
                                .environment(hydrationActivationViewModel)
                                .transition(.opacity)
                        }
                        
                        Tab("Hydratation", systemImage: "drop.fill") {
                            WaterQuantityView(historyViewModel: HistoryViewModel())
                                .transition(.opacity)
                        }
                    }
                    
                } else {
                    TabView (selection: $selectedTab){
                        
                        Tab("Hydratation", image: "water-svgrepo-com",value:0) {
                            HomeView(hasSeenIntro: $showMainApp)
                                .transition(.opacity)
                        }
                        
                        Tab("Hydratation", image: "water-svgrepo-com",value:1) {
                            InformationView(hasSeenIntro: $showMainApp)
                                .transition(.opacity)
                        }
                        
                    }
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    .ignoresSafeArea()
                    .onAppear {
                        UIPageControl.appearance().pageIndicatorTintColor = .gray

//                        UIPageControl
//                            .appearance().currentPageIndicatorTintColor = UIColor(
//                                named: "BackgroundColor"
//                            )
                 
                        
                    }
                }
            }
            .animation(.easeOut, value: showMainApp)
        }
    }
    
    func updateSelectedTab(){
        
    }
  
}

struct ShowTabView: View {
    @State var showMainApp: Bool = false
    @State private var hydrationActivationViewModel = HydrationActivationViewModel()
  
    
  
    var body: some View {
            Group {
                if showMainApp {
                    TabView {
                        
                        Tab("Chronomètre", systemImage : "stopwatch") {
                            Chronograph(hydrationActivationViewModel: hydrationActivationViewModel)
                                .environment(hydrationActivationViewModel)
                                .transition(.opacity)
                        }
                        
                        Tab("Hydratation", systemImage: "drop.fill") {
                            WaterQuantityView(historyViewModel: HistoryViewModel())
                                .transition(.opacity)
                        }
                    }
                    
                } else {
                    TabView{
                        
                        Tab("Hydratation", image:"water-svgrepo-com") {
                            HomeView(hasSeenIntro: $showMainApp)
                                .transition(.opacity)
                        }
                        
                        Tab("Hydratation", systemImage: "drop.fill") {
                            InformationView(hasSeenIntro: $showMainApp)
                                .transition(.opacity)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .always))
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

#Preview
{
    ShowTabView()
}
