//
//  hydrationActivationViewModel .swift
//  SITIENS
//
//  Created by Modibo on 09/04/2025.
//

import Foundation
import UserNotifications
import AVFoundation
import AVKit

@Observable
class HydrationActivationViewModel  {
    var audioPlayer: AVAudioPlayer?
    
    let avAudioEngine = AVAudioEngine()
    let avAudioPlayerNode = AVAudioPlayerNode()
    let hydrationProtocol : HydrationProtocol
    
    init(audioPlayer: AVAudioPlayer? = nil, hydrationProtocol : HydrationProtocol = DataHistoryHub() ) {
        self.audioPlayer = audioPlayer
        self.hydrationProtocol = hydrationProtocol
    }
    
    func playingSound(audioFile : String) {
        hydrationProtocol.playingSound(audioFile: audioFile)
    }
    
    func stopPlaying(){
        hydrationProtocol.stopPlaying()
    }
    
    
    func formatTimer(_ secondes: Int) -> String {
        let hours = secondes / 3600
        let minutes = (secondes % 3600) / 60
        let seconds = (secondes % 3600) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func formatHour(_ secondes : Int) -> String{
        let hours = secondes / 3600
        return String(format: "%2d", hours)
    }
  
    func playSound(sound:String) {
        hydrationProtocol.playSound(sound: sound)
    }
    
    func atuhorzation(){
        hydrationProtocol.atuhorzation()
    }
    
    func notification(){
        hydrationProtocol.notification()
    }
}

