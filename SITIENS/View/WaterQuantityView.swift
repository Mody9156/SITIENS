//
//  WaterQuantityView.swift
//  SITIENS
//
//  Created by Modibo on 16/04/2025.
//

import SwiftUI
import CoreData
import Combine

struct WaterQuantityView: View {
    @State var updateHeight : CGFloat = 0
    @State var sheetPresented : Bool = false
    @State var rotationInfiny : Bool = false
    @State var profilType : String = ""
    @Bindable var userSettingsViewModel = UserSettingsViewModel()
    @State var throwError : Bool = false
    @State var showMessage : Bool = false
    @Bindable var historyViewModel : HistoryViewModel
    @State var progress : CGFloat = 0.0
    @State var startAnimation : CGFloat = 0
    @State private var isScaledUp = false
    @State var glace : String = ""
    
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
                    
                    let currentWater = updateHeight * userSettingsViewModel.updateType(name:profilType)
                    let targetWater = userSettingsViewModel.updateWater(type: profilType)
                    
                    Text("\(currentWater,format: .number.precision(.fractionLength(1)))L / \(targetWater,format: .number.precision(.fractionLength(1)))L")
                        .foregroundStyle(.gray)
                        .font(.title2)
                    
                    GeometryReader { GeometryProxy in
                        let height = GeometryProxy.size.height
                        let width  = GeometryProxy.size.width
                        
                        ZStack{
                            
                            Image(systemName: "drop.fill")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .foregroundStyle(.white)
                            
                            
                            WaterWave(
                                progress: progress,
                                waveHeight:0.1,
                                offset: startAnimation
                            )
                            .fill(Color.blue)
                            .scaleEffect(x: isScaledUp ? 1.1:1,y:isScaledUp ? 1:1.1)
                            .overlay(
                                content: {
                                    ExtractedView()
                                    
                                })
                            .mask {
                                Image(systemName: "drop.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(20)
                            }
                            .overlay(
                                alignment:.bottom
                            ){
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
                                        
                                        guard !profilType.isEmpty, !glace.isEmpty else { return }
                                        let isFull = updateHeight != 300
                                        let updateWater = userSettingsViewModel.updateWater(type:profilType) != 0
                                        
                                        if isFull && updateWater {
                                            
                                            let result = userSettingsViewModel.showNumberOfGlass(
                                                chooseBottle: glace,
                                                name: profilType
                                            )
                                            let water = userSettingsViewModel.uptateQuanittyOfWater2(quantityWater: profilType,chooseBottle: glace)
                                            withAnimation {
                                                updateHeight += CGFloat(water)
                                                
                                                progress += result
                                            }
                                        }
                                    }
                                    
                                } label: {
                                    
                                    Image(systemName: "plus")
                                        .font(.system(size:45,weight:.bold))
                                        .foregroundStyle(.blue)
                                        .shadow(radius: 2)
                                        .padding(25)
                                        .background(
                                            Circle()
                                                .foregroundStyle(.white)
                                                .overlay(content: {
                                                    Circle()
                                                        .stroke(.blue,lineWidth:6)
                                                })
                                        )
                                }
                                
                            }
                            
                            let updateHeight = Int((updateHeight / 300) * 100)
                            
                            Text("\(updateHeight) %")
                                .foregroundStyle(updateHeight >= 150 ? .white: .blue)
                                .font(.title)
                                .offset(y:75)
                            
                        }
                        .frame(
                            width: width,
                            height: height,
                            alignment: .center
                        )
                        .onAppear{
                            withAnimation(
                                .linear(duration: 0.8)
                                .repeatForever(autoreverses: true)){
                                    startAnimation = 300
                                    isScaledUp = true
                                }
                        }
                    }
                    .frame(width: 350)
                    
                    if updateHeight != 0 {
                        
                        Button {
                            withAnimation {
                                updateHeight = 0
                                progress = 0
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
                    
                    if !glace.isEmpty {
                        VStack {
                            HStack{
                                ZStack {
                                    Circle()
                                        .frame(width: 70,height: 70)
                                        .foregroundStyle(.blue)
                                    
                                    Circle()
                                        .frame(width: 70,height: 60)
                                        .foregroundStyle(.white)
                                    Image(userSettingsViewModel.chooseBottleOfWater(name: glace))
                                        .resizable()
                                        .frame(width: 40, height: 40, alignment: .center)
                                }
                            }
                            
                            let type = userSettingsViewModel.UpdateGlaceWithRIghtValues(
                                chooseBottle: glace,
                                name: profilType)
                            let rounded =  type.rounded()
                            
                            Text("X \(Int(rounded))")
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        if progress == 0 {
                            
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
                                UserSettingsView(profil:$profilType,glace:$glace)
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
                    if progress >= 300 {
                        
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

struct WaterWave: Shape {
    var progress : CGFloat
    //Wague
    var waveHeight : CGFloat
    //Animation du début
    var offset : CGFloat
    // Aniamtion
    var animation : CGFloat {
        get{offset}
        set{offset = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            //Start
            path.move(to: .zero)
            
            let progressHeight : CGFloat = (1 - progress) * rect.height
            let height = waveHeight * rect.height
            
            for value in stride(from: 0, to: rect.width, by: 2) {
                let x : CGFloat = value
                let sine : CGFloat = sin(Angle(degrees:  value + offset).radians)
                let y : CGFloat = progressHeight + (height * sine)
                
                path.addLine(to: CGPoint(x: x, y: y))
            }
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
        }
    }
}

struct CircleView: View {
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white.opacity(0.1))
                .frame(
                    width: 15,
                    height: 15
                )
                .offset(x:-20)
            
            Circle()
                .fill(Color.white.opacity(0.1))
                .frame(
                    width: 15,
                    height: 15
                )
                .offset(x:40,y:30)
            
            Circle()
                .fill(Color.white.opacity(0.1))
                .frame(
                    width: 25,
                    height: 25
                )
                .offset(x:-30,y:80)
            
            Circle()
                .fill(Color.white.opacity(0.1))
                .frame(
                    width: 25,
                    height: 25
                )
                .offset(x:50,y:70)
            
            Circle()
                .fill(Color.white.opacity(0.1))
                .frame(
                    width: 10,
                    height: 10
                )
                .offset(x:40,y:100)
            
            Circle()
                .fill(Color.white.opacity(0.1))
                .frame(
                    width: 10,
                    height: 10
                )
                .offset(x:-40,y:50)
        }
    }
}
