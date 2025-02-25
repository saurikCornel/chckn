import SwiftUI

struct MenuView: View {
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
                                Spacer()
                                BalanceTemplate()
                                    .padding()
                            }
                            Spacer()
                        }
                        
                        
                        VStack(spacing: -40) {
                            ButtonTemplateGift(image: "dailyGetBtn", action: {NavResult.shared.currentScreen = .DAILY})
                                .padding(.bottom, 30)
                            
                            ButtonTemplateBig(image: "playBtn", action: {NavResult.shared.currentScreen = .LEVELS})
                            ButtonTemplateBig(image: "trainingBtn", action: {NavResult.shared.currentScreen = .TRAIN})
                            ButtonTemplateBig(image: "shopBtn", action: {NavResult.shared.currentScreen = .SHOP})
                            ButtonTemplateBig(image: "achiveBtn", action: {NavResult.shared.currentScreen = .ACHIVE})
                            ButtonTemplateBig(image: "settingsBtn", action: {NavResult.shared.currentScreen = .SETTINGS})
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

struct ButtonTemplateSmall: View {
    var image: String
    var action: () -> Void

    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 80)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding(10)
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.2)) {
                action()
            }
        }
    }
}

struct ButtonTemplateBig: View {
    var image: String
    var action: () -> Void

    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 100)
                .cornerRadius(10)
                .shadow(radius: 10)
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.2)) {
                action()
            }
        }
    }
}

struct ButtonTemplateGift: View {
    var image: String
    var action: () -> Void

    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .cornerRadius(10)
                .shadow(radius: 10)
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.2)) {
                action()
            }
        }
    }
}

struct BalanceTemplate: View {
    @AppStorage("coinscore") var coinscore: Int = 10
    var body: some View {
        ZStack {
            Image(.balancePlate)
                .resizable()
                .scaledToFit()
                .frame(width: 140, height: 70)
                .overlay(
                    ZStack {
                            Text("\(coinscore)")
                            .foregroundColor(.black)
                            .fontWeight(.heavy)
                            .font(.title3)
                            .position(x: 85, y: 35)
                        
                    }
                )
        }
    }
}

struct ButtonTemplateMiddle: View {
    var image: String
    var action: () -> Void

    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 130, height: 130)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding(10)
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.2)) {
                action()
            }
        }
    }
}

#Preview {
    MenuView()
}
