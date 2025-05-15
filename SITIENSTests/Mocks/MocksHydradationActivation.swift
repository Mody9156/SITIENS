//
//  MocksHydradationActivation.swift
//  SITIENSTests
//
//  Created by Modibo on 15/05/2025.
//

import Testing
@testable import SITIENS
import UserNotifications
import AVFoundation
import AVKit

class MocksHydradationActivation : HydrationProtocol{
    let avAudioEngine = AVAudioEngine()
    let avAudioPlayerNode = AVAudioPlayerNode()
    
    var throwError: Bool = false
    var sound : String = ""
    var messageError : String = ""
    var isPlaying: Bool = false
    
    func playingSound(audioFile: String) {
        guard  !audioFile.isEmpty else {
            messageError = "audioFile is empty"
            isPlaying = false
            return
        }
        
        if throwError {
            messageError = "There are some errors"
            isPlaying = false
        }else {
            sound = audioFile
            messageError = ""
            isPlaying = true
        }
    }

}
