//
//  InfosView.swift
//  SITIENS
//
//  Created by Modibo on 07/04/2025.
//
import SwiftUI


struct InformationView: View {
    @Binding var hasSeenIntro: Bool
    @State private var showSheet: Bool = false
    @State private var openIndicator : Bool = false
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        NavigationStack {
                ValueNavigationLink(hasSeenIntro: $hasSeenIntro, showSheet: $showSheet, openIndicator: $openIndicator)
        }
    }
    
}
struct ValueNavigationLink :View {
    @Binding var hasSeenIntro: Bool
    @Binding var showSheet: Bool
    @Binding var openIndicator : Bool
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        ZStack{
            LinearGradient(
                gradient: Gradient(colors: [.blue.opacity(0.3), .cyan.opacity(0.2)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            if verticalSizeClass == .compact {
                ScrollView {
                    contentViewForShowNavigationLink()
                }
                
            }else {
                contentViewForShowNavigationLink()
            }
        }
        .toolbar(content :{toolBarContent()})
        .sheet(isPresented: $showSheet) {
            RoundedRectangle(cornerRadius: 3)
                .frame(width: 40, height: 5)
                .foregroundColor(.gray.opacity(0.4))
                .padding(.top, 8)
            
            InfoDetailSheet(
                sections: [
                    ("Insomnies et réveils nocturnes", moreText),
                    ("La potomanie : un trouble psychiatrique", potomanie),
                    ("Le coma hydrique : boire trop d’eau, trop vite", hydrique)
                ],
                dismissAction: { showSheet = false }
            )
        }
    }
    
    // MARK: - Contenu à afficher dans la feuille
    private var accebilityLbale: String {
        return "n'avez pas encore ignor l'introduction"
    }
    
    private var moreText: String {
        """
        Si vous buvez trop d’eau avant de dormir, vous risquez de vous réveiller fréquemment. En effet, cela empêche la sécrétion de l’hormone antidiurétique nécessaire à un sommeil profond.
        """
    }
    
    private var potomanie: String {
        """
        La potomanie est un trouble psychiatrique caractérisé par une consommation excessive d’eau. Elle peut mener à de graves complications, dont un œdème cérébral ou un coma.
        """
    }
    
    private var hydrique: String {
        """
        Boire plus de 5 litres d’eau par jour peut entraîner un déséquilibre en sodium, provoquant une intoxication à l’eau, maux de tête, voire un coma potentiellement mortel.
        """
    }
    
    @ToolbarContentBuilder
    func toolBarContent() -> some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button {
                withAnimation {
                    showSheet.toggle()
                }
            } label: {
                Text("!")
                    .foregroundStyle(Color("TextBackground"))
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .glassEffect()
                
                    .onAppear{
                        openIndicator = true
                    }
            }
        }
    }
    
    @ViewBuilder
    func contentViewForShowNavigationLink() -> some View {
        VStack(spacing: 24) {
            Image("thirstyPicture")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 260, height: 260)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white.opacity(0.4), lineWidth: 4))
                .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
                .accessibilityLabel("Image de présentation")
            
            VStack(alignment: .center, spacing: 16){
                
                Text("Boire de l’eau : quelle est la limite à ne pas dépasser ?")
                    .font(.title3)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .accessibilityLabel("Titre de la page")
                
                Button(action: {
                    withAnimation {hasSeenIntro = true }
                }) {
                    Text("Ignorer")
                        .foregroundStyle(Color("ForegroundColorForTheText"))
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                
                .background {
                    ZStack{
                        RoundedRectangle(cornerRadius: 26, style: .continuous)
                            .fill(Color("TextBackground"))
                            .glassEffect()
                    }
                }
                .accessibilityLabel("Ignorer l'introduction")
                .accessibilityValue(hasSeenIntro == true
                                    ? "Introduction ignorée":""
                )
                .padding(.horizontal)
            }
        }
    }
}

// MARK: - Vue de feuille d'information
struct InfoDetailSheet: View {
    let sections: [(String, String)]
    let dismissAction: () -> Void
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Image("thirstyPicture")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                    VStack(alignment: .leading, spacing: 24) {
                        ForEach(sections, id: \.0) { title, text in
                            InfoSection(title: title, text: text)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Les risques d’une surhydratation")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Composant réutilisable pour les sections
struct InfoSection: View {
    let title: String
    let text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color("TextBackground"))
            
            Text(text)
                .font(.body)
                .foregroundStyle(Color("TextBackground"))
        }
    }
}

// MARK: - Preview
#Preview {
    @Previewable @State var seen = false
    InformationView(hasSeenIntro: $seen)
}
