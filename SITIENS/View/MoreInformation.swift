//
//  MoreInformation.swift
//  SITIENS
//
//  Created by Modibo on 30/08/2025.
//

import SwiftUI

struct MoreInformation: View {
    let managementHistory : [ManagementHistory] = []
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.blue.opacity(0.3), .cyan.opacity(0.2)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            ForEach(managementHistory) { history in
                
            VStack {
                
                Spacer()
                
                Text(history.name)
                    .font(.largeTitle)
                    .fontWeight(.thin)
                
                Spacer()
                
                Image("PictureForWater")
                    .resizable()
                    .frame(width: 300,height: 300)
                    .opacity(0.5)
                    .shadow(color: .black,radius: 12)
                
                VStack(alignment: .leading) {
                    
                    
                    HStack {
                        Image(systemName: "drop.fill")
                            .resizable()
                            .foregroundStyle(Color("waterColor"))
                            .frame(width: 40,height: 50)
                        
                        
                        Spacer()
                        
                        Text(history.quantity)
                            .fontWeight(.thin)
                            .font(.system(size: 30))
                    }
                    
                    .padding()
                    
                    HStack {
                        Image(systemName: "calendar")
                            .resizable()
                            .foregroundStyle(Color("waterColor"))
                            .frame(width: 50,height: 50)
                        
                        Spacer()
                        
                        Text(history.date)
                            .fontWeight(.thin)
                            .font(.system(size: 30))
                        
                    }
                    .padding()
                    
                }
                .padding()
                
                Spacer()
            }
            .padding()
            
        }
           
        }
    }
}

#Preview {
    MoreInformation()
}
