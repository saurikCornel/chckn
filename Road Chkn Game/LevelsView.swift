import SwiftUI

struct LevelsView: View {
    @AppStorage("score") var savedCoins: Int = 1
    
    @State private var isModalPresented = false

    var body: some View {
        GeometryReader { geometry in
            var isLandscape = geometry.size.width > geometry.size.height
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

                            }
                            Spacer()
                        }
                        
                        
                        VStack(spacing: -30) {
                            ButtonTemplateBig(image: "easyBtn", action: {NavResult.shared.currentScreen = .GAMEEASY})
                            ButtonTemplateBig(image: "mediumBtn", action: {NavResult.shared.currentScreen = .GAMEMEDIUM})
                            ButtonTemplateBig(image: "hardBtn", action: {NavResult.shared.currentScreen = .GAMEHARD})
                            ButtonTemplateBig(image: "proBtn", action: {NavResult.shared.currentScreen = .GAMEPRO})
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
                Image(.backgroundMenu)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .scaleEffect(1.1)
            )
        }
    }
}



#Preview {
    LevelsView()
}
