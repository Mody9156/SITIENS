//
//  WaterQuantityView.swift
//  SITIENS
//
//  Created by Modibo on 16/04/2025.
//

import SwiftUI

struct WaterQuantityView: View {
    @State var updateHeight : CGFloat = 0
    @State var title : String = "150ml"
    @State var nameOfCategory : String = "Nourrisson"
    @State var sheetPresented : Bool = false
    @State var rotationInfiny : Bool = false
    @State var profilType : String = ""
    @State var mesure = Measurement<UnitLength>(value: 10, unit: .centimeters)
    @State var number = 2.3332/1000
    
    var body: some View {
        NavigationStack {
            VStack{
                
                Text("\(Int((updateHeight / 2) * 200 / 300)) %")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.blue)
                    .padding()
                
                
                Text("\(updateHeight * updateType(name:profilType),format: .number.precision(.fractionLength(1)))L / \(updateWater(type:profilType),format: .number.precision(.fractionLength(1)))L")
                    .foregroundStyle(.gray)
                
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
                        if updateHeight != 300 && updateWater(type:profilType) != 0{
                            updateHeight += 50
                        }
                    }
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 200,height: 50)
                        Text(updateHeight == 300 ? "Objectif atteint" : "Ajouter de l'eau")
                            .foregroundStyle(.white)
                    }
                }
                .padding()
                
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
            }
        }
    }
    
    func updateWater(type name:String) -> CGFloat{
        switch name  {
        case "nourrissons":
            return 0.7
        case "femmes enceintes":
            return 2.5
        case "personnes âgées":
            return 2
        case "sportifs":
            return 3
        default:
            return 0
        }
    }
    
    func updateType(name type: String) -> Double{
        switch type  {
        case "nourrissons":
            return 2.3332/1000
        case "femmes enceintes":
            return 8.36/1000
        case "personnes âgées":
            return 6.66/1000
        case "sportifs":
            return 1/100
        default:
            return 0.0
        }
        
    }
    
    
    
}

#Preview {
    WaterQuantityView()
}
