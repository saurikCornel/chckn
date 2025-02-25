import Foundation


enum AvailableScreens {
    case MENU
    case LOADING
    case SETTINGS
    case ACHIVE
    case SHOP
    case TRAIN
    case TRAIN2
    case LEVELS
    case GAMEEASY
    case GAMEMEDIUM
    case GAMEHARD
    case GAMEPRO
    case DAILY
}

class NavResult: ObservableObject {
    @Published var currentScreen: AvailableScreens = .LOADING
    static var shared: NavResult = .init()
}
