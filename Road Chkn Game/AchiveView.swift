import SwiftUI

struct AchiveView: View {
    @AppStorage("score") var savedCoins: Int = 1
    @AppStorage("achive1") var achive1: Int = 0
    @AppStorage("achive2") var achive2: Int = 0
    @AppStorage("achive3") var achive3: Int = 0
    @AppStorage("achive4") var achive4: Int = 0
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
                                BalanceTemplate()
                                    .padding()
                            }
                            Spacer()
                        }
                        
                        Image(.achivePlate)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                            .padding(.top, 90)
                        
                        VStack {
                            HStack {
                                if achive1 >= 10 {
                                    Image(.achive1)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 110, height: 110)
                                } else {
                                    Image(.achive1Close)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 110, height: 110)
                                }
                                
                                if achive2 >= 5 {
                                    Image(.achive2)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 110, height: 110)
                                } else {
                                    Image(.achive2Close)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 110, height: 110)
                                }
                            }
                            
                            HStack {
                                if achive3 >= 5 {
                                    Image(.achive3)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 110, height: 110)
                                } else {
                                    Image(.achive3Close)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 110, height: 110)
                                }
                                
                                if achive4 >= 1 {
                                    Image(.achive4)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 110, height: 110)
                                } else {
                                    Image(.achive4Close)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 110, height: 110)
                                }
                            }
                        }
                        .padding(.top, 120)
                        
                        
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
    AchiveView()
}
