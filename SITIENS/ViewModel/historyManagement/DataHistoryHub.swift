//
//  DataHistoryHub.swift
//  SITIENS
//
//  Created by Modibo on 15/05/2025.
//

import Foundation
import UserNotifications
import AVFoundation
import AVKit

@Observable
class DataHistoryHub : HydrationProtocol {
    var audioPlayer: AVAudioPlayer?
    
    let avAudioEngine = AVAudioEngine()
    let avAudioPlayerNode = AVAudioPlayerNode()
    
    func playingSound(audioFile: String) {
        guard let url = Bundle.main.url(forResource: audioFile, withExtension: "mp3") else{
            return  print("Erreur lors du chargement du fichier")
        }
        
        do{
            let file = try AVAudioFile(forReading: url)
            avAudioEngine.attach(avAudioPlayerNode)
            
            avAudioEngine
                .connect(
                    avAudioPlayerNode,
                    to: avAudioEngine.outputNode,
                    format: file.processingFormat
                )
            
              avAudioPlayerNode
                .scheduleFile(
                    file,
                    at: nil,
                    completionCallbackType: .dataPlayedBack
                )
            
            try avAudioEngine.start()
            avAudioPlayerNode.play()
            
        }catch {
            print("Erreur pendant la lecture : \(error.localizedDescription)")
        }
    }

    func playSound(sound:String) {
        if let path = Bundle.main.path(forResource: sound, ofType: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
                
            } catch {
                print("ERROR")
            }
        }
    }
    
    func authorization(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if let error = error {
                print("Error requesting authorization: \(error)")
            }
        }
    }
    
    func stopPlaying(){
        avAudioEngine.stop()
        avAudioPlayerNode.stop()
        audioPlayer = nil
    }
    
    func notification(){
        //Contenu de la notification
        let userNotification = UNMutableNotificationContent()
        userNotification.title = "Il est temps de boire de l'eau"

        userNotification.sound = UNNotificationSound.default
        userNotification.body =  "Boire de l'eau est essentiel à notre bien-être"
        
        //Trigger (déclanche quand la notification sera envoyée)
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 5,
            repeats: false
        )
        //Request
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: userNotification,
            trigger: trigger
        )
        
        UNUserNotificationCenter
            .current()
            .add(request)
        
    }
}
