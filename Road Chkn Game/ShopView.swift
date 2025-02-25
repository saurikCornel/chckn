import SwiftUI

struct ShopView: View {
    @AppStorage("coinscore") var playerBalance: Int = 10

    @AppStorage("pairDiscovery") private var pairDiscovery: Int = 0
    @AppStorage("timeDilation") private var timeDilation: Int = 0
    @AppStorage("openCards") private var openCards: Int = 0

    @State private var alertMessage: String? // Для хранения текста алерта
    @State private var showAlert: Bool = false // Отображение алерта

    private let bonusPrice: Int = 50
    private let imageNames: [String] = ["bonusSpeed", "bonusTime"]

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        HStack {
                            Image("back")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .padding(.top, 20)
                                .padding()
                                .foregroundStyle(.white)
                                .onTapGesture {
                                    NavResult.shared.currentScreen = .MENU
                                }
                            Spacer()
                            BalanceTemplate()
                                .padding()
                        }
                        Spacer()
                    }
                    
                    Image(.shopView)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .padding(.top, 90)
                    
                    
                    HStack(spacing: 20) {
                        ForEach(imageNames, id: \.self) { imageName in
                            Button(action: {
                                handleBonusPurchase(for: imageName)
                            }) {
                                Image(imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 110, height: 110)
                                    .padding(.top, 130)
                            }
                        }
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Notification"), message: Text(alertMessage ?? ""), dismissButton: .default(Text("OK")))
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .background(
                    Image(.backgroundMenu)
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .scaleEffect(1.1)
                )
            }
        }
    }

    private func handleBonusPurchase(for imageName: String) {
        if playerBalance >= bonusPrice {
            switch imageName {
            case "bonusSpeed":
                pairDiscovery += 1
            case "bonusTime":
                timeDilation += 1
            default:
                break
            }
            playerBalance -= bonusPrice
            alertMessage = "Purchase successful!" // Сообщение об успешной покупке
        } else {
            alertMessage = "Not enough coins for this purchase!" // Сообщение о недостатке монет
        }
        showAlert = true
    }
}

#Preview {
    ShopView()
}
