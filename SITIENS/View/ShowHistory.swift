//
//  ShowHistory.swift
//  SITIENS
//
//  Created by Modibo on 02/05/2025.
//

import SwiftUI

struct ShowHistory: View {
    @Binding var historyManager : [HistoryManager]
    var dateformatted = Date.now.formatted(date: .numeric, time: .shortened)
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 8) {
                Text("Historique")
                    .font(.system(size: 40, weight: .light, design: .serif))
                    .foregroundStyle(.gray)
                    .padding()
                
                ForEach(historyManager) { historyManager in
                    if historyManager.name.isEmpty{
                        Text("Vide")
                            .font(.caption)
                    }else{
                        Text("\(dateformatted)")
                        HStack(spacing: 12){
                            Text("\(historyManager.name) :")
                                .foregroundStyle(.blue)
                                .font(.callout)
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(width: 80, height: 30)
                                    .foregroundStyle(.blue)
                                Text("\(historyManager.quantity)ml")
                                    .foregroundStyle(.white)
                            }
                            Image(systemName: "drop.degreesign")
                                .foregroundStyle(.blue)
                        }
                        
                    }
                    
                    
                }
            }
            .padding()
        }
    }
}

#Preview {
    @Previewable @State var historyManager : [HistoryManager] = [HistoryManager(name: "Sportif", quantity: "11.00"),HistoryManager(name: "Jeune", quantity: "11.00"),HistoryManager(name: "Sportif", quantity: "4.00"),HistoryManager(name: "Sportif", quantity: "1.00"),HistoryManager(name: "Sportif", quantity: "11.00"),HistoryManager(name: "Agée", quantity: "11.00"),HistoryManager(name: "Sportif", quantity: "3.00"),HistoryManager(name: "Sportif", quantity: "11.00"),HistoryManager(name: "Enfant", quantity: "1.00"),HistoryManager(name: "Sportif", quantity: "11.00"),HistoryManager(name: "Sportif", quantity: "11.00"),HistoryManager(name: "Femme", quantity: "2.00"),HistoryManager(name: "Sportif", quantity: "0.70"),HistoryManager(name: "Sportif", quantity: "11.00"),HistoryManager(name: "Homme", quantity: "11.00"),HistoryManager(name: "Sportif", quantity: "11.00"),HistoryManager(name: "Sportif", quantity: "11.00"),HistoryManager(name: "Sportif", quantity: "3.00"),HistoryManager(name: "Sportif", quantity: "11.00"),HistoryManager(name: "Sportif", quantity: "11.00")]
    ShowHistory(historyManager:$historyManager )
}
