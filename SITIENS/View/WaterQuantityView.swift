//
//  WaterQuantityView.swift
//  SITIENS
//
//  Created by Modibo on 16/04/2025.
//

import SwiftUI
import CoreData

struct WaterQuantityView: View {
    @State var updateHeight : CGFloat = 0
    @State var title : String = "150ml"
    @State var nameOfCategory : String = "Nourrisson"
    @State var sheetPresented : Bool = false
    @State var rotationInfiny : Bool = false
    @State var profilType : String = ""
    @State var mesure = Measurement<UnitLength>(value: 10, unit: .centimeters)
    @State var number = 2.3332/1000
    @Bindable var userSettingsViewModel = UserSettingsViewModel()
    @State var throwError : Bool = false
    @State var showMessage : Bool = false
    @Bindable var historyViewModel : HistoryViewModel
    @State var name : String = ""
    @State var quantity : String = ""
    @State private var level: CGFloat = 50
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.blue.opacity(0.3), .cyan.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack{
                    Text("Hydradation")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.blue)
                        .padding()
                    
                    Text("\(updateHeight * userSettingsViewModel.updateType(name:profilType),format: .number.precision(.fractionLength(1)))L / \(userSettingsViewModel.updateWater(type:profilType),format: .number.precision(.fractionLength(1)))L")
                        .foregroundStyle(.gray)
                        .font(.title2)
                    
                    ZStack {
                        ZStack(alignment: .bottom) {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 200, height: 300)
                                .foregroundColor(.clear)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.blue, lineWidth: 2)
                                )
                            
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 200, height: updateHeight)
                                .foregroundStyle(.blue)
                                .animation(.easeInOut, value: updateHeight)
                            
                            Text("\(Int(updateHeight / 3))%")
                                .font(.caption)
                                .foregroundColor(.white)
                                .bold()
                                .padding(.bottom, 8)
                        }
                        .padding()
                    }

                    
                    Button {
                        withAnimation {
                            throwError = true
                            showMessage = false
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                                withAnimation {
                                    showMessage = true
                                }
                            })
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                                withAnimation {
                                    showMessage = false
                                    throwError = false
                                }
                            })
                            
                            if updateHeight != 300 && userSettingsViewModel.updateWater(type:profilType) != 0{
                                withAnimation {
                                    updateHeight += 50
                                }
                            }
                        }
                        
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .frame(height: 50)
                                .foregroundStyle(updateHeight == 300 ? .green : .blue)
                                .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 2)

                            HStack {
                                Text(updateHeight == 300 ? "Objectif atteint" : "Ajouter de l'eau")
                                    .foregroundStyle(.white)
                                       .fontWeight(.semibold)
                                       .font(.system(size: 16))
                                
                                if updateHeight != 300  {
                                    Image(systemName: "drop.fill" )
                                        .foregroundStyle(.white)
                                }
                            }
                            
                        }
                        .padding(.horizontal)
                    }
                    
                    .padding()
                    
                    
                    
                    if updateHeight != 0 {
                        
                        Button {
                            withAnimation {
                                updateHeight = 0
                            }
                            
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(height: 50)
                                    .foregroundStyle(.orange)
                                    .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 2)

                              
                                HStack {
                                    Text("Reinitialiser")
                                        .foregroundStyle(.white)
                                    Image(systemName: "arrow.counterclockwise")
                                        .foregroundStyle(.white)
                                }
                                
                            }
                        }
                        .padding()
                    }
                    
                    if throwError && profilType.isEmpty {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundStyle(Color.orange)
                            Text("Veuillez bien selectionner un profil")
                        }
                        .opacity(showMessage ? 1 : 0)
                        .animation(
                            .easeOut(duration: 1.0),value: showMessage
                        )
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        if updateHeight == 0 {
                            
                            Button {
                                withAnimation {
                                    sheetPresented = true
                                }
                            } label: {
                                Image(systemName: "gearshape.fill")
                                    .font(.title2)
                                    .foregroundStyle(.primary)
                                    .rotationEffect(.degrees(rotationInfiny ? 360 : 0))
                                    .animation(
                                        .linear(duration: 2.9)
                                        .repeatForever(autoreverses: false),
                                        value: rotationInfiny
                                    )
                                    .onAppear{
                                        rotationInfiny = true
                                    }
                            }
                            
                            .sheet(isPresented: $sheetPresented) {
                                
                            } content: {
                                UserSettingsView(profil:$profilType)
                            }
                            
                        }else{
                            
                            Image(systemName: "gearshape.fill")
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                        
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        NavigationLink {
                            ShowHistory(
                                historyViewModel:HistoryViewModel(
                                    viewContext: historyViewModel.viewContext)
                            )
                            .onAppear{
                                historyViewModel.reload()
                            }
                            
                        } label: {
                            Image(systemName: "clock.arrow.circlepath")
                                .font(.title2)
                                .foregroundStyle(.blue)
                        }
                        
                        
                    }
                    
                }
                .onChange(of: updateHeight) {
                    if updateHeight == 300 {
                        
                        historyViewModel.name = profilType
                        
                        let formattedQuantity = String(format: "%.1fL", Double(updateHeight) * userSettingsViewModel.updateType(name: profilType))
                        historyViewModel.quantity = formattedQuantity
                        
                        Task{
                            do{
                                try historyViewModel.addHistory()
                            }catch{
                                print("Erreur lors du test de l'ajout de l'historique : \(error)")
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    WaterQuantityView(historyViewModel: HistoryViewModel())
}
