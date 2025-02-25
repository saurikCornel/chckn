import SwiftUI

struct TrainingGame: View {
    @AppStorage("score") var savedCoins: Int = 1
    @State private var isModalPresented = false
    @State private var clickCount = 0 // Tracks the number of clicks
    @State private var currentFrame = "frame1" // Current chicken animation frame
    @State private var progressImage = "progress1" // Current progress bar image
    
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
                                    .padding()
                            }
                            Spacer()
                        }
                        
                        
                        
                        VStack {
                            VStack(spacing: 60) {
                                Image("yourSpeedText")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 250, height: 100)
                                
                                Image(progressImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 250, height: 80)
                            }
                            Spacer()
                            
                            Image("tapText")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250, height: 100)
                        }
                        
                        Image("ellipse")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                        
                        Image(currentFrame)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 250)
                            .onTapGesture {
                                handleChickenTap() // Handle tap logic
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
    
    // Function to handle chicken tap logic
    private func handleChickenTap() {
        clickCount += 1
        
        // Animate chicken by cycling through frames
        switch currentFrame {
        case "frame1":
            currentFrame = "frame2"
        case "frame2":
            currentFrame = "frame3"
        case "frame3":
            currentFrame = "frame1"
        default:
            currentFrame = "frame1"
        }
        
        // Update progress bar and handle navigation based on click count
        switch clickCount {
        case 10:
            progressImage = "progress2"
        case 30:
            progressImage = "progress3"
        case 31:
            NavResult.shared.currentScreen = .TRAIN2 // Переход на TRAIN2
        default:
            break
        }
    }
}

#Preview {
    TrainingGame()
}

