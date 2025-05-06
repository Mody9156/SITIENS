//
//  ShowHistory.swift
//  SITIENS
//
//  Created by Modibo on 02/05/2025.
//

import SwiftUI

struct ShowHistory: View {
    @Binding var historyManager : [HistoryManager]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            ForEach(historyManager) { historyManager in
                if historyManager.name.isEmpty{
                    Text("Vide")
                        .font(.caption)
                }else{
                    HStack(spacing: 12){
                        Text(historyManager.name)
                            .foregroundStyle(.blue)
                            .font(.callout)
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: 80, height: 30)
                                .foregroundStyle(.blue)
                            Text("\(historyManager.quantity)ml")
                                .foregroundStyle(.white)
                        }
                        Image(systemName: "drop.degreesign.fill")
                            .foregroundStyle(.blue)
                    }
                }
                
                
            }
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var historyManager : [HistoryManager] = [HistoryManager(name: "Sportif", quantity: "11.00"),HistoryManager(name: "Sportif", quantity: "11.00"),HistoryManager(name: "Sportif", quantity: "11.00"),HistoryManager(name: "Sportif", quantity: "11.00")]
    ShowHistory(historyManager:$historyManager )
}
