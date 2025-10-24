//
//  ConfigureTimer.swift
//  SITIENS
//
//  Created by Modibo on 10/04/2025.
//

import SwiftUI
import UIKit
import AVFAudio
import Combine
import MediaPlayer
import SwiftUIIntrospect

struct TimerSettings: View {
    @State var sound : [String] = ["asphalt-sizzle","clover-feast","fresh-breeze","alone","kugelsicher-by-tremoxbeatz","gardens-stylish-chill","future-design","lofi-effect","lofi-sample-if-i-cant-have-you","mystical-music","music-box","meditation-music-sound-bite","ringtone","cool-guitar-loop","basique"]
    @State var hour : [Int] = [10,600,3600,7200,5400,1800]
    @State var inserTimerHour = Array(0..<24)
    @State var inserTimerMinutes = Array(0..<61)
    @State var inserHour = 0
    @State var inserMinutes = 0
    @Binding var selectedItems : String
    @Binding var selectedHour : Int
    @Environment(\.dismiss) var dismiss
    @Bindable var hydrationActivationViewModel : HydrationActivationViewModel
    @AppStorage("hour",store: .standard) var timerhour : Int = 0
    @State private var audio : AVAudioPlayer?
    @State  var isPlaying : Bool = false
    @State private var cancellable: AnyCancellable?
    @State private var slide : Double = 0.0
    @State private var activeSlide : Bool = false
    @Environment(\.scenePhase) var scenePhase
    @State private var updateSlide : Double = 0.0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var progress: Double = 0.0
    @State private var isUserScrubbing = false
    @State private var time = 0
    @State private var isVisualizing : Bool = false
    @State var activeBoutton: Bool = false
    
    func formatTime(_ hour :Int,_ minutes:Int ) -> Int {
        let a = (hour * 3600) + (minutes * 60)
        return a
    }
    
    private func CombienEquatableTime() -> CombienEquatable {
        return CombienEquatable(inserHour: inserHour, inserMinutes: inserMinutes)
    }
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.blue.opacity(0.3), .cyan.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack{
                        HStack{
                            Picker("",selection: $inserHour) {
                                ForEach(inserTimerHour, id: \.self) { value in
                                      Text("\(value)")
                                        
                                }
                            }
                            
                            .pickerStyle(.wheel)
                            .padding()
                            .clipped()
                            .introspect(.picker(style: .wheel), on: .iOS(.v13, .v14, .v15, .v16, .v17)) {
//                                picker.subviews[1].backgroundColor = UIColor.clear // or any color you want
                                print(type(of: $0))
                            }
                            
                            Picker("",selection: $inserMinutes) {
                                ForEach(inserTimerMinutes, id: \.self) { value in
                                    Text("\(value)")
                                }
                            }
                            .pickerStyle(.wheel)
                            .padding()
                            .clipped()
                            .introspect(.picker(style: .wheel), on: .iOS(.v13, .v14, .v15, .v16, .v17)) { picker in
                                picker.subviews[1].backgroundColor = UIColor.clear // or any color you want
                            }
                        }
                        .onChange(of: CombienEquatableTime()) {
                            let result = formatTime(inserHour, inserMinutes)
                            selectedHour = result
                            let _ = hydrationActivationViewModel.formatHour(result)
                        }
                        
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Picker(selection: $selectedItems, label: HStack {
                                Text("Sélectionner")
                                    .foregroundColor(Color("TextBackground"))
                                    .padding()
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color("TextBackground"))
                                    .padding()
                            }) {
                                ForEach(sound, id: \.self) { item in
                                    Text(item)
                                }
                            }
                            .pickerStyle(.navigationLink)
                            
                            .background(.gray.opacity(0.7))
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.gray, lineWidth: 1)
                            )
                            .accessibilityLabel("Sélectionner un son")
                            .accessibilityHint("Double-cliquez pour choisir un audio")
                        }
                    }
                    .padding()
                }
                .toolbar {
                    ToolBarItem()
                }
            }
        }
        .onDisappear{
            hydrationActivationViewModel.stopPlaying()
            isPlaying = false
        }
        .environment(hydrationActivationViewModel.self)
        
    }
    
    @ToolbarContentBuilder
    func ToolBarItem() -> some ToolbarContent {
        
        ToolbarItem(placement: .topBarTrailing) {
            Button(action: {
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    timerhour = selectedHour
                    hydrationActivationViewModel.stopPlaying()
                    if selectedHour != 0  {
                        dismiss()
                    }
                }
                
            }) {
                Text("Valider")
                    .foregroundStyle(Color("TextBackground"))
                    .font(.headline)
                    .padding()
            }
            .disabled(test() == true)
        }
        
        ToolbarItem(placement: .topBarLeading) {
            
            Button(action: {
                dismiss()
                
            }) {
                Text("Fermer")
                    .foregroundStyle(Color("TextBackground"))
                    .font(.headline)
                    .padding()
            }
        }
        
        ToolbarItem(placement: .principal) {
            Text("Paramètres")
        }
    }
    
    func test () -> Bool {
        if inserHour == 0 && inserMinutes == 0 {
            return true
        }
        return false
    }
    
    
}

struct CombienEquatable : Equatable {
    let inserHour : Int
    let inserMinutes : Int
}

#Preview {
    @Previewable @State var selectedItems : String = ""
    @Previewable @State var selectedHour : Int = 0
    TimerSettings(
        selectedItems: $selectedItems,
        selectedHour: $selectedHour,
        hydrationActivationViewModel: HydrationActivationViewModel()
    )
    //        @Previewable @State var selectedItems : String = ""
    //        @Previewable @State var isVisualizing : Bool = false
    //    @Previewable @State var sound : [String] = [""]
    //    @Previewable @State var hydrationActivationViewModel =  HydrationActivationViewModel()
    //    @Previewable @State var isPlaying : Bool = false
    //
    //    ActiveAudio(
    //        selectedItems: $selectedItems,
    //        isVisualizing:$isVisualizing,
    //        sound:$sound,
    //        hydrationActivationViewModel: HydrationActivationViewModel(),
    //        isPlaying: $isPlaying
    //    )
}

struct CustomButton: View {
    @Binding var isPlaying : Bool
    @Bindable var hydrationActivationViewModel : HydrationActivationViewModel
    @Binding var selectedItems : String
    var type : String
    @AppStorage("hour",store: .standard) var timerhour : Int = 0
    @Binding var selectedHour : Int
    @Environment(\.dismiss) var dismiss
    @Binding var updateSlide : Double
    @Binding var inserMinutes : Int
    @Binding var inserHour : Int
    //    func completed() -> Bool {
    //        return progressWater() == 1
    //    }
    //
    //    func progressWater() -> CGFloat {
    //        return  CGFloat(timeInterval) / CGFloat(timerhour)
    //    }
    
    var body: some View {
        if type == "LoadingSong" {
            Button {
                withAnimation {
                    isPlaying.toggle()
                    
                    if isPlaying {
                        hydrationActivationViewModel.playSound(sound: selectedItems)
                        
                    }else{
                        hydrationActivationViewModel.stopPlaying()
                    }
                }
                
            } label: {
                Image(systemName:isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .frame(width: 100,height: 100)
                    .padding()
                    .scaleEffect(isPlaying ? 1.1 : 1.0)
                    .foregroundStyle(.black)
            }
            
        }else{
            
            Button {
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    timerhour = selectedHour
                    hydrationActivationViewModel.stopPlaying()
                    if selectedHour != 0  {
                        dismiss()
                    }
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 50)
                    Text("Valider")
                        .foregroundStyle(.white)
                }
            }
            .disabled(test() == true)
            .padding()
        }
    }
    //    inserMinutes
    func test () -> Bool {
        if inserHour == 0 && inserMinutes == 0 {
            return true
        }
        return false
    }
}


struct ShowTheButton :View {
    @Binding var activeBoutton: Bool
    @Binding var selectedItems : String
    @Binding var isVisualizing : Bool
    @Bindable var hydrationActivationViewModel : HydrationActivationViewModel
    @State var isPlaying : Bool
    @Binding var sound : [String]
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .frame(height:80)
                .foregroundStyle(Color("ForegroundColorForTheText"))
            
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 50,height: 50)
                        .foregroundStyle(Color("TextBackground"))
                        .padding()
                    
                    Text(
                        selectedItems.isEmpty ? "?" : selectedItems.prefix(3).uppercased()
                    )
                    .padding()
                    .foregroundStyle(Color("ForegroundColorForTheText"))
                    .font(Font.system(size: 15, design: .default))
                }
                
                Text(
                    selectedItems.isEmpty ? "?" : selectedItems.prefix(3).uppercased()
                )
                .padding()
                .foregroundStyle(Color("TextBackground"))
                .font(Font.system(size: 25, design: .default))
                
                Spacer()
                
                //                CustomSystemName(name: "play.fill", isVisualizing: $isVisualizing)
                
                Button {
                    withAnimation {
                        if !selectedItems.isEmpty {
                            isPlaying.toggle()
                        }
                        isVisualizing.toggle()
                        
                        if isPlaying  {
                            hydrationActivationViewModel.playSound(sound: selectedItems)
                            
                        }else{
                            hydrationActivationViewModel.stopPlaying()
                        }
                    }
                    
                } label: {
                    Image(systemName:isPlaying ? "pause.fill" : "play.fill")
                        .resizable()
                        .frame(width: 30,height: 30)
                        .padding()
                        .scaleEffect(isPlaying ? 1.1 : 1.0)
                        .foregroundStyle(selectedItems.isEmpty ? .gray : Color("TextBackground"))
                }
                
                
                
                Button {
                    let randomElement = sound.randomElement()!
                    
                    if !selectedItems.isEmpty {
                        isPlaying = true
                        hydrationActivationViewModel.playSound(sound: randomElement)
                    }
                } label: {
                    HStack(spacing: -35) {
                        Image(systemName: "arrowtriangle.forward.fill")
                            .resizable()
                            .foregroundStyle(!selectedItems.isEmpty ? Color("TextBackground") :.gray)
                            .frame(width: 20,height: 20)
                            .padding()
                        
                        Image(systemName: "arrowtriangle.forward.fill")
                            .resizable()
                            .foregroundStyle(!selectedItems.isEmpty ? Color("TextBackground") :.gray)
                            .frame(width: 20,height: 20)
                            .padding()
                    }
                }
            }
        }
        .onTapGesture {
            activeBoutton.toggle()
        }
        .sheet(isPresented: $activeBoutton) {
            ActiveAudio(
                selectedItems: $selectedItems,
                isVisualizing:$isVisualizing,
                sound: $sound,
                hydrationActivationViewModel: hydrationActivationViewModel,
                isPlaying: $isPlaying
            )
        }
    }
}


struct ActiveAudio : View {
    @Binding var selectedItems : String
    @Binding var isVisualizing : Bool
    @Binding var sound : [String]
    @Bindable var hydrationActivationViewModel : HydrationActivationViewModel
    @Binding var isPlaying : Bool
    let volum = AVAudioSession.sharedInstance().outputVolume
    
    var body: some View {
        
        VStack(alignment: .center) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 200,height: 200)
                    .foregroundStyle(Color("TextBackground"))
                    .padding()
                
                Text(
                    selectedItems.isEmpty ? "?" : selectedItems.prefix(3).uppercased()
                )
                .padding()
                .foregroundStyle(Color("ForegroundColorForTheText"))
                .font(.largeTitle)
            }
            
            VStack {
                HStack {
                    
                    Text(selectedItems.isEmpty ? "?" : selectedItems)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                        .font(.title2)
                    
                    Spacer()
                    
                    //                        HStack(spacing: 1) {
                    //                            ForEach(0..<6) { _ in
                    //                                RoundedRectangle(cornerRadius: 2)
                    //                                    .frame(
                    //                                        width: 3,
                    //                                        height:
                    //                                                .random(
                    //                                                    in: isVisualizing ? 8...16 : 4...12
                    //                                                )
                    //                                    )
                    //                                    .foregroundStyle(.black)
                    //                                    .animation(
                    //                                        .easeOut(duration: 0.25)
                    //                                        .repeatForever(autoreverses: true),
                    //                                        value: isVisualizing
                    //                                    )
                    //                                    .onAppear{
                    //                                        isVisualizing = false
                    //                                    }
                    //                            }
                    //                        }.padding()
                }
                .padding()
                
                
                
                HStack{
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "15.arrow.trianglehead.counterclockwise")
                            .resizable()
                            .foregroundStyle(selectedItems.isEmpty ? .gray : .black)
                            .frame(width: 50,height: 50)
                            .padding()
                    }
                    
                    CustomSystemName(
                        name: "play.fill",
                        selectedItems: $selectedItems,
                        isVisualizing: $isVisualizing
                    )
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "30.arrow.trianglehead.clockwise")
                            .resizable()
                            .foregroundStyle(selectedItems.isEmpty ? .gray : .black)
                            .frame(width: 50,height: 50)
                            .padding()
                    }
                }
                
                VolumeSlider()
                    .frame(height: 40)
                    .foregroundStyle(.blue)
                    .padding()
            }
        }
    }
}

struct CustomSystemName: View {
    let name : String
    @Binding var selectedItems : String
    @Binding var isVisualizing : Bool
    var body: some View {
        
        Button {
            isVisualizing.toggle()
        } label: {
            Image(systemName: name)
                .resizable()
                .foregroundStyle(selectedItems.isEmpty ? .gray : .black)
                .frame(width: 50,height: 50)
                .padding()
        }
    }
}


extension MPVolumeView {
    static func setVolume(_ volume: Float){
        let volumeView = MPVolumeView()
        let slider = volumeView.subviews.first { $0 is UISlider } as? UISlider
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            slider?.value = volume
        }
    }
}

struct VolumeSlider: UIViewRepresentable {
    func makeUIView(context: Context) -> MPVolumeView {
        let volumeView = MPVolumeView()
        //        volumeView.showsRouteButton = true // Affiche le bouton AirPlay
        volumeView.showsVolumeSlider = true
        return volumeView
    }
    func updateUIView(_ uiView: MPVolumeView, context: Context) {}
}
