//
//  ShowHistory.swift
//  SITIENS
//
//  Created by Modibo on 02/05/2025.
//

import SwiftUI

struct ShowHistory: View {
    let historyManager : [HistoryManager] = []
    
    var body: some View {
        ScrollView {
            VStack {
                List(historyManager) { historyManager in
                    Text(historyManager.name)
                    Text(historyManager.quantity)
                }
                Text("Recent")
                    .foregroundStyle(.blue)
                    .font(.headline)
            }
        }
    }
}

#Preview {
    ShowHistory()
}
