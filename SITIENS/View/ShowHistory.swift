//
//  ShowHistory.swift
//  SITIENS
//
//  Created by Modibo on 02/05/2025.
//

import SwiftUI
import CoreData

struct ShowHistory: View {
    @Bindable var historyViewModel : HistoryViewModel
    @Environment(\.dismiss) var dismiss
    var dateformatted = Date.now.formatted(date: .numeric, time: .shortened)
    @State private var searchText = ""
    
    var body: some View {
        ZStack {
         
            LinearGradient(
                gradient: Gradient(colors: [.blue.opacity(0.3), .cyan.opacity(0.2)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 16) {

                Text("Historique d'hydratation")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundStyle(.blue)
                    .padding(.top, 10)

                List {
                    Section {
                        ForEach(search, id: \.self) { historyManager in
                            if let name = historyManager.name,
                               let quantity = historyManager.quantity,
                               let date = historyManager.date,
                               !name.isEmpty,
                               !quantity.isEmpty {
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(.ultraThinMaterial)
                                        .background(
                                            RoundedRectangle(cornerRadius: 16)
                                                .fill(Color.blue.opacity(0.05))
                                        )
                                        .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
                                    
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text(date)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                        
                                        HStack {
                                            Text("\(name) :")
                                                .font(.headline)
                                                .foregroundStyle(.blue)
                                            
                                            Spacer()
                                            
                                            HStack(spacing: 6) {
                                                Image(systemName: "drop.fill")
                                                    .foregroundColor(.white)
                                                
                                                Text("\(quantity)")
                                                    .foregroundColor(.white)
                                                    .font(.subheadline.bold())
                                            }
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(Color.blue)
                                            .cornerRadius(10)
                                        }
                                    }
                                    .padding()
                                }
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .padding(.vertical, 4)
                            }
                        }
                        .onDelete(perform: historyViewModel.deleteHistory)
                    }
                }
                .searchable(text: $searchText)
                .listStyle(.plain)
            }
           
            .padding()
            .navigationBarBackButtonHidden(true)
            .toolbar {
                // 🔙 Bouton retour
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            dismiss()
                        }
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                            Text("Hydratation")
                        }
                        .foregroundStyle(.blue)
                    }
                }
                
               
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
            .onAppear {
                Task {
                    try? historyViewModel.fetchHistory()
                }
            }
        }
        
    }
    
    var search : [History]{
        if searchText.isEmpty {
           return historyViewModel.history
        }else{
           
            return historyViewModel.history
                .filter{
                    $0.name?.contains(searchText) == true                }
        }
        
    }
}

#Preview {
    
    ShowHistory(
        historyViewModel: HistoryViewModel()
    )
}
