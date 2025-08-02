//
//  InformationViewToAppClip.swift
//  AppClip
//
//  Created by Modibo on 02/08/2025.
//

import SwiftUI

struct InformationViewToAppClip: View {
    @Binding var hasSeenIntro: Bool
    @State private var showSheet: Bool = false
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    @Previewable @State var hasSeenIntro: Bool = false
    InformationViewToAppClip(hasSeenIntro: $hasSeenIntro)
}
