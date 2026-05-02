///Users/must/Documents/SITIENS/SITIENS/Model/ManagementHistory.swift
//  ExportCSV.swift
//  SITIENS
//
//  Created by Modibo on 24/04/2026.
//

import Foundation
import CoreData

struct ExportCSV {
    
    func exportCSV(context:NSManagedObjectContext){
        let request = NSFetchRequest<NSManagedObject>(entityName: "History")
        var minutesSinceLAstDrink : Int = 0
        
        do{
            let result = try context.fetch(request)
            
            guard !result.isEmpty else {
                print("données vide")
                return
            }
            
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "fr_FR")
            formatter.dateFormat = "dd/MM/yyyy, HH:mm"
            
            var entries : [ManagementHistory] = []
            
            for results in result{
                let name = results.value(forKey: "name") as? String ?? ""
                let quantity = results.value(forKey: "quantity") as? String ?? ""
                let date = results.value(forKey: "date") as? String ?? ""
                
                
                guard let realDate = formatter.date(from: date) else {
                    print("Mauvaise date")
                    continue // si date valdie passe à l'entrée suivante
                }
                
                let entry = ManagementHistory(name: name, quantity: quantity, date: date)
                entries.append(entry)
                
            }
            
            let sorted = entries.sorted { a, b in
                formatter.date(from: a.date)! < formatter.date(from: b.date)!
            }
            
            let csvRow : [String] = []
            
            for (index,entry) in sorted.enumerated() {
                guard let entryDay = formatter.date(from: entry.date) else {continue}
                
                let hour = Calendar.current.component(.hour, from: entryDay)
                let dayOfWeek = Calendar.current.component(
                    .weekday,
                    from: entryDay
                ) - 1
                
                if index == 0 {
                    minutesSinceLAstDrink = 120
                }else {
                    let previousEntry = sorted[index - 1]
                    guard let previousEntryDate = formatter.date(from: previousEntry.date) else { continue }
                    let diff = entryDay.timeIntervalSince(previousEntryDate) / 60
                    minutesSinceLatDrink = Int(diff)
                    
                }
                
            }
            
        }catch{
            
            print("❌ Erreur fetch : \(error)")
        }
        
    }
}
