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
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 8) {
                Text("Historique")
                    .font(.system(size: 40, weight: .light, design: .serif))
                    .foregroundStyle(.gray)
                    .padding()
               
                ForEach(historyViewModel.history) { historyManager in
                    
                    if let name =  historyManager.name, let quantity =  historyManager.quantity, let date =  historyManager.date{
                    
                    if name.isEmpty{
                        Text("Vide")
                            .font(.caption)
                    }else{
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.ultraThinMaterial)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.blue.opacity(0.1))
                                )
                                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(date)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                HStack(spacing: 10) {
                                    Text("\(name) :")
                                        .font(.headline)
                                        .foregroundColor(.blue)
                                    
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.blue)
                                            .frame(width: 80, height: 32)
                                        Text("\(quantity)")
                                            .foregroundColor(.white)
                                            .font(.subheadline)
                                    }
                                    
                                    Image(systemName: "drop.fill")
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding()
                        }
                        .padding(.horizontal)
                        
                    }
                }
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            dismiss()
                        }
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Hydradation")
                        }
                    }

                }
            })
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

    ShowHistory(
        historyViewModel: HistoryViewModel()
    )
}
