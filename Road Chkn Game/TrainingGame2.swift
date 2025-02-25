import SwiftUI

struct TrainingGame2: View {
    @AppStorage("score") var savedCoins: Int = 1
    @State private var isModalPresented = false
    @State private var wheelAngle: Double = 0.0 // Текущий угол поворота колеса
    @State private var isSpinning = false // Флаг, крутится ли колесо
    @State private var gameResult: String? = nil // Результат игры (победа/поражение)
    @State private var timer: Timer? = nil // Таймер для вращения

    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            ZStack {
                if !isLandscape {
                    ZStack {
                        VStack {
                            VStack(spacing: 60) {
                                Image("yourSpeedText")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 250, height: 100)
                                
                                Image("arrow")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .padding(.top, 30)
                            }
                            Spacer()
                            
                            Image("getGreenText")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250, height: 100)
                        }
                        
                        Image("wheel")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 320, height: 320)
                            .rotationEffect(.degrees(wheelAngle)) // Применяем поворот
                            .onTapGesture {
                                stopWheel() // Останавливаем колесо при нажатии
                            }
                            .onAppear {
                                startSpinning() // Начинаем вращение при появлении
                            }
                    }
                    
                    // Показываем результат игры, если он есть
                    if let result = gameResult {
                        if gameResult == "win" {
                            WinView()
                        } else {
                            LoseView()
                        }
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
                Image("backgroundTraining")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .scaleEffect(1.05)
            )
        }
    }
    
    // Начинаем вращение колеса с помощью таймера
    private func startSpinning() {
        guard !isSpinning else { return }
        isSpinning = true
        timer?.invalidate() // Останавливаем старый таймер, если он есть
        timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
            wheelAngle += 2.0 // Увеличиваем угол на 2 градуса каждые 0.02 секунды
            if wheelAngle >= 360.0 {
                wheelAngle = 0.0 // Сбрасываем на 0 после полного оборота
            }
        }
    }
    
    // Останавливаем колесо и проверяем условие победы
    private func stopWheel() {
        guard isSpinning else { return }
        isSpinning = false
        timer?.invalidate() // Останавливаем таймер
        timer = nil
        
        // Для отладки выводим текущий угол в консоль
        print("Остановлено на угле: \(wheelAngle)")
        
        // Проверяем, попал ли угол в диапазон ±20 градусов от 0 (начальной позиции)
        let targetRange = 0.0...20.0 // Диапазон от 0 до 20 градусов
        let isInPositiveRange = targetRange.contains(wheelAngle)
        let isInNegativeRange = (wheelAngle >= 340.0 && wheelAngle <= 360.0) // Диапазон от 340 до 360
        let isInRange = isInPositiveRange || isInNegativeRange
        
        if isInRange {
            gameResult = "win"
            savedCoins += 10 // Награда за побе
        } else {
            gameResult = "lose"
        }
    }
}

struct WinView: View {

    var body: some View {
        ZStack {
            Image("winPlate")
                .resizable()
                .scaledToFit()
                .frame(width: 250)
            
            VStack(spacing: -30) {
                Button(action: {}) {
                    Image("retryBtn")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 80)
                        .onTapGesture {
                            NavResult.shared.currentScreen = .TRAIN
                        }
                }
                
                Image("menuBtn")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 80)
                    .onTapGesture {
                        NavResult.shared.currentScreen = .MENU
                    }
            }
            .padding(.top, 120)
        }
    }
}

struct LoseView: View {

    var body: some View {
        ZStack {
            Image(.losePlate)
                .resizable()
                .scaledToFit()
                .frame(width: 250)
            
            VStack(spacing: -20) {
                Button(action: {}) {
                    Image(.retryBtn)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 90)
                        .onTapGesture {
                            NavResult.shared.currentScreen = .TRAIN
                        }
                }
                
                Image(.menuBtn)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 90)
                    .onTapGesture {
                        NavResult.shared.currentScreen = .MENU
                    }
            }
            .padding(.top, 40)
        }
    }
}

#Preview {
    TrainingGame2()
}


