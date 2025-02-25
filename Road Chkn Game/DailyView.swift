import SwiftUI

struct DailyView: View {
    @AppStorage("coinscore") var coinscore: Int = 10
    @AppStorage("dailyRewardClaimed") private var dailyRewardClaimed: Bool = false // Флаг получения награды
    @AppStorage("lastClaimTime") private var lastClaimTime: Double = 0.0 // Время последнего получения в секундах с 1970

    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            ZStack {
                if !isLandscape {
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
                        
                        
                        VStack {
                            Spacer()
                            Image("returnBtn") // Предполагаю, что это строка, а не .returnBtn
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250, height: 100)
                                .opacity(isRewardAvailable() ? 1.0 : 0.5) // Затемнение, если недоступно
                                .onTapGesture {
                                    if isRewardAvailable() {
                                        claimReward()
                                    }
                                }
                        }
                        
                        Image("giftIcon") // Предполагаю, что это строка
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width / 2, height: geometry.size.height / 2)
                    }
                } else {
                    ZStack {
                        Color.black.opacity(0.7)
                            .edgesIgnoringSafeArea(.all)
                        RotateDeviceScreen()
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(
                Image("backgroundMenu") // Предполагаю, что это строка
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .scaleEffect(1.1)
            )
        }
    }
    
    // Проверка, доступна ли награда
    private func isRewardAvailable() -> Bool {
        if !dailyRewardClaimed {
            return true // Если ещё не получали, доступно
        }
        
        let currentTime = Date().timeIntervalSince1970
        let timeSinceLastClaim = currentTime - lastClaimTime
        let twentyFourHours: Double = 24 * 60 * 60 // 24 часа в секундах
        
        return timeSinceLastClaim >= twentyFourHours // Доступно, если прошло 24 часа
    }
    
    // Получение награды
    private func claimReward() {
        coinscore += 10 // Добавляем монеты (текущая логика)
        NavResult.shared.currentScreen = .MENU // Переход в меню (текущая логика)
        
        // Обновляем состояние
        dailyRewardClaimed = true
        lastClaimTime = Date().timeIntervalSince1970 // Сохраняем текущее время
    }
}



#Preview {
    DailyView()
}
