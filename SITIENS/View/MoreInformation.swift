//
//  MoreInformation.swift
//  SITIENS
//
//  Created by Modibo on 30/08/2025.
//

import SwiftUI

struct MoreInformation: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.blue.opacity(0.3), .cyan.opacity(0.2)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                Text("Pofils")
                    .font(.largeTitle)
                    .fontWeight(.thin)
                
                Spacer()
                
                Image("round")
                    .resizable()
                    .frame(width: 300,height: 300)
                    .opacity(0.5)
                    .shadow(color: .black,radius: 12)
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "drop.fill")
                            .foregroundStyle(.blue)
                        
                        Text("3.0L")
                            .fontWeight(.thin)
                    }
                    .padding()
                    
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundStyle(.blue)
                        
                        Text("12/11:25 11:55")
                            .fontWeight(.thin)
                    }
                    .padding()
                }
                
               
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    MoreInformation()
}
