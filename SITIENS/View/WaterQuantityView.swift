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
    @AppStorage("updateHeight") private var updateHeightRaw: Double = 0
    @AppStorage("progress") private var progressRaw: Double = 0
    @AppStorage("profilTypeRaw") private var selectedSound: String = ""
    @AppStorage("glaceRaw") private var selectedGlace: String = ""
    @State var updateHeight : CGFloat = 0
    @State var sheetPresented : Bool = false
    @Bindable var userSettingsViewModel = UserSettingsViewModel()
    @State var throwError : Bool = false
    @State var showMessage : Bool = false
    @Bindable var historyViewModel : HistoryViewModel
    @State var progress : CGFloat = 0.0
    @State var startAnimation : CGFloat = 0
    @State private var isScaledUp = false
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var currentWater : CGFloat {
        updateHeight * userSettingsViewModel.updateType(name:selectedSound)
    }
    
    var targetWater : CGFloat {
        userSettingsViewModel.updateWater(type: selectedSound)
    }
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundGradient
                
                if verticalSizeClass == .compact {
                    ScrollView {
                         container
                    }
                    
                }else {
                    container
                }
            }
        }
    }
    
    private var container : some View {
        VStack{
            Text("Hydradation")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(Color.blue)
                .padding()
            
            Text("\(currentWater > targetWater ? targetWater : currentWater ,format: .number.precision(.fractionLength(1)))L / \(targetWater,format: .number.precision(.fractionLength(1)))L")
                .foregroundStyle(.gray)
                .font(.title2)
                .padding()
            
            ZStack(alignment: .topLeading) {
                if updateHeight != 0 {
                    
                    Button {
                        withAnimation {
                            updateHeight = 0
                            progress = 0
                        }
                        
                    } label: {
                        ZStack {
                            Circle()
                                .fill(.orange.gradient)
                                .frame(width: 70, height: 70)
                                .shadow(color: .black.opacity(0.25), radius: 6, y: 4)

                            Image(systemName: "arrow.clockwise")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundStyle(.white)
                                .symbolRenderingMode(.hierarchical)
                        }
                        .padding()
                       
                    }
                    .padding()
                    .accessibilityLabel("Réinitialiser le suivi")
                    .accessibilityHint("Remet le niveau d'eau et la progression à zéro")
                    .accessibilityAddTraits(.isButton)
                }
                
                ZStack(alignment:.topTrailing) {
                    ZStack{
                        
                        Image(systemName: "drop.fill")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fill)
                            .foregroundStyle(.white.opacity(0.6))
                            .padding()
                        
                        WaterWave(
                            progress: progress,
                            waveHeight:0.1,
                            offset: startAnimation
                        )
                        .fill(Color.blue)
                        .scaleEffect(x: isScaledUp ? 1.1:1,y:isScaledUp ? 1:1.1)
                        .overlay(
                            content: {
                                CircleView(width: 15, height: 15, x: -20, y: 0)
                                CircleView(width: 15, height: 15, x: 40, y: 30)
                                CircleView(width: 25, height: 25, x: -30, y: 80)
                                CircleView(width: 25, height: 25, x: 50, y: 70)
                                CircleView(width: 10, height: 10, x: 40, y: 100)
                                CircleView(width: 10, height: 10, x: -40, y: 50)
                                
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
                            increaseWaterAmount(
                                throwError: $throwError,
                                showMessage: $showMessage,
                                selectedSound: $selectedSound,
                                selectedGlace: $selectedGlace,
                                updateHeight: $updateHeight,
                                userSettingsViewModel: userSettingsViewModel,
                                progress: $progress
                            )
                        }
                        
                        let percentFilled = (updateHeight / 300) * 100
                        
                        if progress > 1.0 {
                            Text("100 %")
                                .foregroundStyle(updateHeight >= 150 ? .white: .blue)
                                .font(.title)
                                .offset(y:75)
                            //attention
                        }else {
                            Text("\(Int(percentFilled)) %")
                                .foregroundStyle(Int(percentFilled) > 40 ? .white: .blue)
                                .font(.title)
                                .offset(y:40)
                        }
                        
                    }
                    .padding()
                    .frame(
                        maxWidth: verticalSizeClass == .compact ? 300 : .infinity,
                        maxHeight: verticalSizeClass == .compact ? 300 : .infinity,
                        alignment: .center
                    )
                    .onAppear{
                        updateHeight = CGFloat(updateHeightRaw)
                        progress = CGFloat(progressRaw)
                        
                        withAnimation(
                            .linear(duration: 0.8)
                            .repeatForever(autoreverses: true)){
                                startAnimation = 300
                                isScaledUp = true
                            }
                    }
                    .padding()
                    
                    
                    if !selectedGlace.isEmpty {
                        VStack {
                            HStack{
                                ZStack {
                                    Circle()
                                        .frame(width: 70,height: 70)
                                        .foregroundStyle(.blue)
                                    
                                    Circle()
                                        .frame(width: 70,height: 60)
                                        .foregroundStyle(.white)
                                    Image(userSettingsViewModel.chooseBottleOfWater(name: selectedGlace))
                                        .resizable()
                                        .frame(width: 40, height: 40, alignment: .center)
                                }
                            }
                            
                            let type = userSettingsViewModel.uptateQuanittyOfWater(
                                quantityWater : selectedSound,
                                chooseBottle:selectedGlace
                            )
                            
                            let rounded = ceil(type)
                            
                            Text("X \(Int(rounded))")
                            
                        }
                        .padding()
                    }
                    
                }
                .padding()
            }
            
           
            
            if throwError && selectedSound.isEmpty {
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
            settingsToolbar
            historyToolbar
        }
        .onChange(of: updateHeight) {
            updateHeightRaw = Double(updateHeight)
            progressRaw = Double(progress)
            
            updateHeight = min(max(updateHeight, 0), 300)
            progress = min(max(progress, 0), 1.0)
            
            if updateHeight >= 300 {
                
                historyViewModel.name = selectedSound
               
                let formattedQuantity = String(format: "%.1fL", Double(updateHeight) * userSettingsViewModel.updateType(name: selectedSound))
                
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
        .onChange(of: progress) {
            progress = min(max(progress, 0), 1.0)
            progressRaw = Double(progress)
        }
    }
    
    private var backgroundGradient: some View {
        LinearGradient(
            gradient: Gradient(colors: [.blue.opacity(0.3), .cyan.opacity(0.2)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
    
    
    private var settingsToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            if progress == 0 {
                
                Button {
                    withAnimation {
                        sheetPresented = true
                    }
                } label: {
                    Image(systemName: "gearshape.fill")
                        .font(.title2)
                        .foregroundStyle(.blue)
                        
                }
                .sheet(isPresented: $sheetPresented) {
                    
                } content: {
                    UserSettingsView(
                        selectedSound: $selectedSound,
                        selectedGlace: $selectedGlace
                    )
                }

            }else{
                
                Image(systemName: "gearshape.fill")
                    .font(.title2)
                    .foregroundColor(.gray)
            }
        }
    }
    
    private var historyToolbar :some ToolbarContent {
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
}

#Preview {
    WaterQuantityView(
        historyViewModel: HistoryViewModel()
    )
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
            
//            let waveAmplitude = waveHeight * rect.height
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
    let width : CGFloat
    let height : CGFloat
    let x : CGFloat
    let y : CGFloat
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white.opacity(0.1))
                .frame(
                    width: width,
                    height: height
                )
                .offset(x: x, y: y)
        }
    }
}

struct increaseWaterAmount : View {
    @Binding var throwError : Bool
    @Binding var showMessage : Bool
    @Binding var selectedSound : String
    @Binding var selectedGlace : String
    @Binding var updateHeight : CGFloat
    @Bindable var userSettingsViewModel = UserSettingsViewModel()
    @Binding var progress : CGFloat
    @Environment(\.verticalSizeClass) var verticalSizeClass
    var body: some View {
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
                
                guard !selectedSound.isEmpty, !selectedGlace.isEmpty else { return }
                
                let isFull = updateHeight != 300
                let updateWater = userSettingsViewModel.updateWater(type:selectedSound) != 0
                
                if isFull && updateWater && progress < 1 {
                    
                    let result = userSettingsViewModel.showNumberOfGlass(
                        chooseBottle: selectedGlace,
                        name: selectedSound
                    )
                    let water = userSettingsViewModel.uptateQuanittyOfWater2(quantityWater: selectedSound,chooseBottle: selectedGlace)
                    
                    withAnimation {
                            updateHeight += water
                            progress += result
                    }
                }
            }
            
        } label: {
            
            Image(systemName: "plus")
                .font(.system(size: 45,weight:.bold))
                .foregroundStyle(.blue)
                .shadow(radius: 2)
                .padding(verticalSizeClass == .compact ? 12 : 25)
                .background(
                    Circle()
                        .foregroundStyle(.white.opacity(0.6))
                        .overlay(content: {
                            Circle()
                                .stroke(.blue,lineWidth:verticalSizeClass == .compact ? 3 : 6)
                        })
                )
        }
        .accessibilityLabel("Ajouter un verre d'eau")
        .accessibilityHint("Ajoute la quantité d'eau choisie au suivi journalier")
        .accessibilityAddTraits(.isButton)
    }
}

