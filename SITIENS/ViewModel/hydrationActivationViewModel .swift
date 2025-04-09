//
//  hydrationActivationViewModel .swift
//  SITIENS
//
//  Created by Modibo on 09/04/2025.
//

import Foundation
import UserNotifications


class hydrationActivationViewModel : ObservableObject {
    
    func notification(){
        //Contenu de la notification
        let userNotification = UNMutableNotificationContent()
        userNotification.title = "Il est temps de boire de l'eau"
        userNotification.sound = UNNotificationSound.default
        userNotification.body = "Boire de l'eau est essentiel à notre bien-être"
        
        //Date d'activation
        var dateComponents = DateComponents()
        dateComponents.hour = 0

        
        
        //Répéter la notification
        for hour in stride(from: 8, to: 20, by: 1){
            dateComponents.hour = hour
            
            //Trigger (déclanche quand la notification sera envoyée)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            //Request
            let request = UNNotificationRequest(identifier: "hydradation \(hour)", content: userNotification, trigger: trigger)
            UNUserNotificationCenter.current().add(request)

        }
        
        
    }
    
}

