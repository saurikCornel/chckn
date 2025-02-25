import SwiftUI

struct GamePro: View {
    @AppStorage("score") var savedCoins: Int = 1
    @State private var timer: Int = 30 // Таймер в секундах
    @State private var isModalPresented = false
    @State private var carPosition: CGFloat = 0 // Позиция машины (от 0 до 1)
    @State private var chickenPosition: CGFloat = 0 // Позиция курицы (от 0 до 1)
    @State private var clickCount = 0 // Количество кликов по кнопке
    @State private var currentChikFrame = "chik1" // Текущий кадр курицы
    @State private var gameTimer: Timer? = nil // Таймер для игры
    @State private var gameResult: String? = nil // Результат игры
    @State private var isPaused = false // Флаг паузы
    @AppStorage("pairDiscovery") private var pairDiscovery: Int = 0 // Количество бонусов скорости
    @AppStorage("timeDilation") private var timeDilation: Int = 0 // Количество бонусов времени
    @State private var requiredClicks: Int = 100 // Необходимое количество кликов для победы
    @AppStorage("achive4") var achive4: Int = 0

    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            ZStack {
                if !isLandscape {
                    ZStack {
                        // UI элементы
                        VStack {
                            HStack {
                                Image("pause")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .onTapGesture {
                                        pauseGame() // Останавливаем игру при нажатии
                                    }
                                    .padding()
                                Spacer()
                                TimeTemplate(time: timer)
                                    .padding()
                            }
                            Spacer()
                        }
                        
                        // Кнопка Tap
                        VStack {
                            Spacer()
                            Image("tapBtn")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 130, height: 130)
                                .onTapGesture {
                                    if !isPaused { handleTap() } // Работает только если не на паузе
                                }
                        }
                        
                        // Бонусы
                        VStack {
                            Spacer()
                            HStack(spacing: 180) {
                                Image("speedBonus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .opacity(pairDiscovery > 0 ? 1.0 : 0.5) // Затемнение если 0
                                    .padding()
                                    .onTapGesture {
                                        if !isPaused && pairDiscovery > 0 { applySpeedBonus() }
                                    }
                                
                                Image("timeBonus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .opacity(timeDilation > 0 ? 1.0 : 0.5) // Затемнение если 0
                                    .padding()
                                    .onTapGesture {
                                        if !isPaused && timeDilation > 0 { applyTimeBonus() }
                                    }
                            }
                        }
                        
                        // Машина и курица
                        HStack {
                            VStack(spacing: 100) {
                                Image("car")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 110, height: 110)
                                    .offset(x: carPosition * (geometry.size.width - 110)) // Движение вправо
                                
                                Image(currentChikFrame)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 110, height: 110)
                                    .offset(x: chickenPosition * (geometry.size.width - 110)) // Движение вправо
                            }
                            Spacer()
                        }
                        
                        // Результат игры или пауза
                        if let result = gameResult {
                            if result == "win" {
                                WinViewLevel()
                            } else {
                                LoseView()
                            }
                        } else if isPaused {
                            PauseView(resumeAction: resumeGame) // Передаем функцию возобновления
                        }
                    }
                    .onAppear {
                        startGame() // Запуск игры при появлении
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
                Image("backgroundGame")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .scaleEffect(1.1)
            )
        }
    }
    
    // Запуск игры
    private func startGame() {
        gameTimer?.invalidate() // Останавливаем старый таймер, если есть
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if !isPaused { // Продолжаем только если не на паузе
                timer -= 1
                carPosition += 1.0 / 20.0 // Машина доходит до конца за 30 секунд
                checkGameResult()
                if timer <= 0 {
                    gameTimer?.invalidate()
                    if gameResult == nil {
                        gameResult = "lose" // Машина дошла первой
                    }
                }
            }
        }
    }
    
    // Остановка игры (пауза)
    private func pauseGame() {
        isPaused = true
        gameTimer?.invalidate() // Останавливаем таймер
    }
    
    // Возобновление игры
    private func resumeGame() {
        isPaused = false
        startGame() // Перезапускаем таймер с текущего состояния
    }
    
    // Обработка нажатия на кнопку Tap
    private func handleTap() {
        clickCount += 1
        chickenPosition = CGFloat(clickCount) / CGFloat(requiredClicks) // Курица доходит до конца за requiredClicks кликов
        
        // Анимация курицы
        switch currentChikFrame {
        case "chik1":
            currentChikFrame = "chik2"
        case "chik2":
            currentChikFrame = "chik3"
        case "chik3":
            currentChikFrame = "chik1"
        default:
            currentChikFrame = "chik1"
        }
        
        checkGameResult()
    }
    
    // Применение бонуса скорости
    private func applySpeedBonus() {
        pairDiscovery -= 1 // Уменьшаем количество бонусов
        requiredClicks = max(1, requiredClicks - 10) // Уменьшаем требуемое количество кликов, минимум 1
        chickenPosition = CGFloat(clickCount) / CGFloat(requiredClicks) // Пересчитываем позицию курицы
        checkGameResult()
    }
    
    // Применение бонуса времени
    private func applyTimeBonus() {
        timeDilation -= 1 // Уменьшаем количество бонусов
        timer += 15 // Добавляем 15 секунд
    }
    
    // Проверка результата игры
    private func checkGameResult() {
        if chickenPosition >= 1.0 && carPosition < 1.0 {
            gameResult = "win"
            achive4 += 1
            gameTimer?.invalidate()
        } else if carPosition >= 1.0 && chickenPosition < 1.0 {
            gameResult = "lose"
            gameTimer?.invalidate()
        }
    }
}



#Preview {
    GamePro()
}

