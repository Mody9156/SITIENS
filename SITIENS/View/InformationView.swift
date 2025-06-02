//
//  InfosView.swift
//  SITIENS
//
//  Created by Modibo on 07/04/2025.
//

import SwiftUI

struct InformationView: View {
    @Binding var activeNavLink: Bool
    @State private var activeBool : Bool = false
    
    var moreText : String {
        return   """
        Si vous buvez trop d’eau dans la journée et notamment avant d’aller vous coucher, vous risquez de vous réveiller plusieurs fois dans la nuit. En temps normal, notre cerveau sécrète une hormone antidiurétique durant le sommeil pour nous permettre de dormir sans être réveillé dans la nuit par l’envie d’aller aux toilettes. Le travail des reins est alors ralenti et on peut profiter d’un bon sommeil réparateur. Mais si l’on boit trop avant d’aller se coucher, cela perturbe cet équilibre et empêche la sécrétion de cette hormone. Il est donc conseillé d’arrêter de boire environ 3 heures avant d’aller au lit.
        """
    }
    
    var potomanie : String {
        """
        La potomanie est diagnostiquée lorsqu’une personne ne peut pas s’empêcher de boire en quantité très importante, pouvant aller jusqu’à 20 litres par jour ! Ce trouble psychiatrique est souvent associé aux troubles du comportement alimentaires comme l’anorexie ou la boulimie. La potomanie touche essentiellement des individus en quête de perfection qui boivent de grandes quantités d’eau, pensant purifier leur corps. Or c’est tout le contraire qui risque se produire : œdème cérébral, coma…, les individus souffrant de potomanie risquent une réelle intoxication à l’eau. Eh oui, il est possible de s’intoxiquer avec de l’eau.
        """
    }
    
    var hydrique : String {
        """
          Tout le monde connaît le coma éthylique qui résulte d’une consommation excessive d’alcool dans des délais courts. Pour l’eau, c’est pareil. Si vous buvez plus de 5 litres d’eau par jour, vous mettez votre organisme en danger en déséquilibrant l’équilibre du sodium dans le corps.

          La diététicienne Anne-Sophie Kruger explique ce qui se risque de se produire « Si vous buvez trop d’eau, les reins ne peuvent pas drainer l’excès assez rapidement, ce qui entraîne une dilution du sang et une baisse de sa concentration en sel. » Et que se passe-t-il lorsque le sang est trop dilué et trop peu concentré en sel ? Dans ce cas, les cellules se gonflent et principalement les cellules du cerveau, avec pour conséquence une augmentation de la pression dans le crâne. L’individu commence à avoir des maux de tête pouvant aller jusqu’à l’intoxication à l’eau potentiellement mortelle.                  
        """
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                LinearGradient(
                    gradient: Gradient(colors: [.blue.opacity(0.3), .cyan.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                activeNavLink = true
                            }
                            
                        }) {
                            Text("Ignorer")
                                .font(.headline)
                                .foregroundStyle(.black)
                                .padding()
                                .background(Color.white)
                                .clipShape(Capsule())
                        }
                        .accessibilityLabel("Passer l’introduction")
                        
                    }
                    .padding()
                    
                    Image("thirstyPicture")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 350, height: 350)
                        .clipShape(Circle())
//                        .overlay(Circle().stroke(Color.black, lineWidth: 4))
                        .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
                    
                    ScrollView {
                        VStack(alignment: .leading) {
                            Text("Boire de l’eau : quelle est la limite à ne pas dépasser ?")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                            
                            Text("""
                                D’une manière générale, il est fortement déconseillé de boire plus de 5 litres d’eau par jour, \
                                car une grande quantité d’eau risque de diluer les constantes sanguines. Voyons quelles peuvent \
                                être les différentes conséquences d’une surconsommation d’eau.
                                """)
                            .font(.body)
                            .padding()
                            .background(Color.gray.opacity(0.05))
                            .cornerRadius(8)
                            
                            

                        }
                        .padding()
                        
                        Button {
                            withAnimation {
                                activeBool.toggle()
                            }
                            
                        } label: {
                            Text( activeBool ?  "Réduire" : "Plus")
                                .fontWeight(.medium)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(Color.blue.opacity(0.1))
                                        .cornerRadius(8)
                        }
                        .sheet(isPresented: $activeBool) {
                            ScrollView {
                                ZStack {
                                    LinearGradient(
                                        gradient: Gradient(colors: [.blue.opacity(0.3), .cyan.opacity(0.2)]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                    .ignoresSafeArea()
                                    
                                    VStack(alignment: .center, spacing: 16) {
                                        Text("Insomnies et/ou réveils nocturnes")
                                            .fontWeight(.bold)
                                            .font(.title2)
                                            
                                        Text(moreText)
                                            .font(.body)
                                        
                                        Text("La potomanie: un trouble psychiatrique à ne pas négliger")
                                            .fontWeight(.bold)
                                            .font(.title2)
                                        
                                        Text(potomanie)
                                            .font(.body)
                                        
                                        Text("Le coma hydrique : boire trop d’eau, trop vite")
                                            .fontWeight(.bold)
                                            .font(.title2)
                                        
                                        Text(hydrique)
                                            .font(.body)
                                        
                                        Button("x") {
                                            dissMiss()
                                        }
                                        .fontWeight(.medium)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(Color.blue.opacity(0.1))
                                        .cornerRadius(8)
                                        .accessibilityLabel("Fermer la page")
                                        .accessibilityHint("Fermer une fenêtre avec plus d’informations")
                                    }
                                    .padding()
                                }
//
                            }
                        }
                    }
                }
            }
        }
    }
func dissMiss(){
    activeBool = false
}

}

#Preview {
    @Previewable @State var activeNavLink: Bool = false
    InformationView(activeNavLink: $activeNavLink)
}



