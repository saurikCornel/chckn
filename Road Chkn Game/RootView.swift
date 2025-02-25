import Foundation
import SwiftUI


struct RootView: View {
    @ObservedObject var nav: NavResult = NavResult.shared
    var body: some View {
        switch nav.currentScreen {
                                        
        case .MENU:
            MenuView()
        case .LOADING:
            LoadingScreen()
        case .SETTINGS:
            SettingsView()
        case .ACHIVE:
            AchiveView()
        case .SHOP:
            ShopView()
        case .TRAIN:
            TrainingGame()
        case .TRAIN2:
            TrainingGame2()
        case .LEVELS:
            LevelsView()
        case .GAMEEASY:
            GameEasy()
        case .GAMEMEDIUM:
            GameMedium()
        case .GAMEHARD:
            GameHard()
        case .GAMEPRO:
            GamePro()
        case .DAILY:
            DailyView()
            
        }

    }
}
