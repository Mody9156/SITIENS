//
//  ShowHistory.swift
//  SITIENS
//
//  Created by Modibo on 02/05/2025.
//

import SwiftUI
import CoreData

struct ShowHistory: View {
    @Binding var historyManager : [HistoryManager]
    @Bindable var historyViewModel : HistoryViewModel
    
    var dateformatted = Date.now.formatted(date: .numeric, time: .shortened)
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 8) {
                Text("Historique")
                    .font(.system(size: 40, weight: .light, design: .serif))
                    .foregroundStyle(.gray)
                    .padding()
                
                ForEach(historyViewModel.history) { historyManager in
                    if let name = historyManager.name {
                        Text("nom :\(name)")
                    }
                }
//                
//                ForEach(historyManager) { historyManager in
//                    if historyManager.name.isEmpty{
//                        Text("Vide")
//                            .font(.caption)
//                    }else{
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 20)
//                                .fill(.ultraThinMaterial)
//                                .background(
//                                    RoundedRectangle(cornerRadius: 20)
//                                        .fill(Color.blue.opacity(0.1))
//                                )
//                                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
//
//                            VStack(alignment: .leading, spacing: 8) {
//                                Text(dateformatted)
//                                    .font(.caption)
//                                    .foregroundColor(.gray)
//
//                                HStack(spacing: 10) {
//                                    Text("\(historyManager.name) :")
//                                        .font(.headline)
//                                        .foregroundColor(.blue)
//
//                                    ZStack {
//                                        RoundedRectangle(cornerRadius: 10)
//                                            .fill(Color.blue)
//                                            .frame(width: 80, height: 32)
//                                        Text("\(historyManager.quantity) ml")
//                                            .foregroundColor(.white)
//                                            .font(.subheadline)
//                                    }
//
//                                    Image(systemName: "drop.fill")
//                                        .foregroundColor(.blue)
//                                }
//                            }
//                            .padding()
//                        }
//                        .padding(.horizontal)
//                    
//                    }
//                }
            }
            .padding()
        }
        .onAppear{
            Task{
                try historyViewModel.fetchHistory()
            }
           
        }
    }
}

#Preview {
    @Previewable @State var historyManager : [HistoryManager] = [HistoryManager(name: "Sportif", quantity: "11.00"),HistoryManager(name: "Jeune", quantity: "11.00"),HistoryManager(name: "Sportif", quantity: "4.00"),HistoryManager(name: "Sportif", quantity: "1.00"),HistoryManager(name: "Sportif", quantity: "11.00"),HistoryManager(name: "Agée", quantity: "11.00"),HistoryManager(name: "Sportif", quantity: "3.00"),HistoryManager(name: "Sportif", quantity: "11.00"),HistoryManager(name: "Enfant", quantity: "1.00"),HistoryManager(name: "Sportif", quantity: "11.00"),HistoryManager(name: "Sportif", quantity: "11.00"),HistoryManager(name: "Femme", quantity: "2.00"),HistoryManager(name: "Sportif", quantity: "0.70"),HistoryManager(name: "Sportif", quantity: "11.00"),HistoryManager(name: "Homme", quantity: "11.00"),HistoryManager(name: "Sportif", quantity: "11.00"),HistoryManager(name: "Sportif", quantity: "11.00"),HistoryManager(name: "Sportif", quantity: "3.00"),HistoryManager(name: "Sportif", quantity: "11.00"),HistoryManager(name: "Sportif", quantity: "11.00")]

    ShowHistory(
        historyManager:$historyManager,
        historyViewModel: HistoryViewModel()
    )
}
