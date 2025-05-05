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
        VStack(alignment: .leading) {
                ForEach(historyManager,id:\.name) { historyManager in
                    Text(historyManager.name)
                        .foregroundStyle(.blue)
                    HStack{
                        Text("\(historyManager.quantity)ml")
                            .foregroundStyle(.blue)
                        Image(systemName: "drop.degreesign.fill")
                            .foregroundStyle(.blue)
                    }
                }
        }
    }
}

#Preview {
    @Previewable @State var historyManager : [HistoryManager] = [HistoryManager(name: "Sportif", quantity: "11.00")]
    ShowHistory(historyManager:$historyManager )
}
