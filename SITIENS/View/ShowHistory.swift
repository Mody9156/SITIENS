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
            VStack {
                List(historyManager,id:\.name) { historyManager in
                    Text(historyManager.name)
                        .foregroundStyle(.blue)
                    Text(historyManager.quantity)
                        .foregroundStyle(.blue)
                }
                Text("Recent")
                    .foregroundStyle(.blue)
                    .font(.headline)
        }
    }
}

#Preview {
    @Previewable @State var historyManager : [HistoryManager] = [HistoryManager(name: "alone", quantity: "11.00")]
    ShowHistory(historyManager:$historyManager )
}
