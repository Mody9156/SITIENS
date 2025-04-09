//
//  hydrationActivationViewModel .swift
//  SITIENS
//
//  Created by Modibo on 09/04/2025.
//

import Foundation
import UserNotifications


class HydrationActivationViewModel : ObservableObject {
    
    
    
    func notification(){
        //Contenu de la notification
        let userNotification = UNMutableNotificationContent()
        userNotification.title = "Il est temps de boire de l'eau"
        userNotification.sound = UNNotificationSound.default
        userNotification.body = "Boire de l'eau est essentiel à notre bien-être"
      
            
            //Trigger (déclanche quand la notification sera envoyée)
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 1,
            repeats: false
        )
            //Request
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: userNotification,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request){ error in
            if let error = error {
                           print("Erreur lors de l'ajout de la notification: \(error)")
                       }
        }
    }
}

