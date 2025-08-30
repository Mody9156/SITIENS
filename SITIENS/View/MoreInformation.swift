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
            
            Text("Hello, World!")
        }
    }
}

#Preview {
    MoreInformation()
}
