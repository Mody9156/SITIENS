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
    
    
    var body: some View {
        NavigationStack {
            VStack{
            
                Text("\(Int((updateHeight / 2) * 200 / 300)) %")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.blue)
                    .padding()
                
                Text("\(updateHeight * userSettingsViewModel.updateType(name:profilType),format: .number.precision(.fractionLength(1)))L / \(userSettingsViewModel.updateWater(type:profilType),format: .number.precision(.fractionLength(1)))L")
                    .foregroundStyle(.gray)
                    .font(.title2)
                
                ZStack (alignment: .bottom){
                    RoundedRectangle(cornerRadius: 6)
                        .frame(width: 200,height: 300)
                        .foregroundStyle(.white)
                        .overlay {
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.blue, lineWidth: 2)
                        }
                    
                    RoundedRectangle(cornerRadius: 6)
                        .frame(width: 200,height: updateHeight)
                        .foregroundStyle(.blue)
                        .overlay {
                            RoundedRectangle(cornerRadius: 6)
                                .foregroundStyle(Color.blue)
                        }
                }
                .padding()
                
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
                            updateHeight += 50
                        }
                    }
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 200,height: 80)
                        Text(updateHeight == 300 ? "Objectif atteint" : "Ajouter de l'eau")
                            .foregroundStyle(.white)
                    }
                }
                .padding()
                
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
                
                if updateHeight == 300 {
                    
                    Button {
                        withAnimation {
                            updateHeight = 0
                        }
                        
                        
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: 200,height: 80)
                                .foregroundStyle(.orange)
                            
                            Text("Reinitialiser")
                                .foregroundStyle(.white)
                        }
                    }
                    .padding()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
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

#Preview {
    WaterQuantityView(historyViewModel: HistoryViewModel())
}
