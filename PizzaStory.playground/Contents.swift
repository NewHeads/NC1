
import SwiftUI
import PlaygroundSupport
import AVFoundation

struct ContentView: View {

    @State var audioPlayer: AVAudioPlayer?
    @State var willMoveToSecondScreen = false
    @State var onTop = true
    @State var eraptionYCoordinate: CGFloat = 149
    @State var smallPizzaYCoordinate: CGFloat = -45
    @State var smallPizzaRotationDegree: Double = 0
    @State var bigEraptionYCoordinate: CGFloat = -610
    @State var bigEraptionFrame:(CGFloat, CGFloat) = (500, 700)
    @State var bigPizzaXCoordinate: CGFloat = -90
    @State var bigPizzaYCoordinate: CGFloat = -600
    @State var bigPizzaRotationDegree: Double = -45
    @State var bigPizzaFrame:(CGFloat, CGFloat) = (200, 200)
    
    @State var selected = false
    public var body: some View {
            ZStack {
                Image(uiImage: UIImage(named: "1BACKGROUND")!)
                    .resizable()
                    .onAppear {
                        self.playAudio()
                    }
                Image(uiImage: UIImage(named: "1CRATERE")!)
                    .resizable()
                    .offset(x: selected ? 0 : 10)
                    .onAppear {
                        withAnimation {
                            selected = !selected
                        }
                    }
                    .animation(Animation.default.repeatCount(56).speed(6).delay(11))
                Image(uiImage: UIImage(named: "1ERUPTION")!)
                    .resizable()
                    .offset(x: 80, y: eraptionYCoordinate)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1).delay(12)) {
                            eraptionYCoordinate = -200
                        }
                        withAnimation(.easeIn(duration: 1).delay(13)) {
                            eraptionYCoordinate = -600
                        }
                    }
                Image(uiImage: UIImage(named: "1pizza")!)
                    .resizable()
                    .frame(width: 70, height: 70)
                    .rotationEffect(.degrees(smallPizzaRotationDegree))
                    .offset(x: 115, y: smallPizzaYCoordinate)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1).delay(12.5)) {
                            smallPizzaYCoordinate = -400
                            smallPizzaRotationDegree = 200
                        }
                    }
                Image(uiImage: UIImage(named: "1VESUVIO")!)
                    .resizable()
                    .offset(x: selected ? 0 : 10)
                    .onAppear {
                        withAnimation {
                            selected = !selected
                        }
                    }
                    .animation(Animation.default.repeatCount(56).speed(6).delay(11))
                Image(uiImage: UIImage(named: "1SKYLINE")!)
                    .resizable()
                Image(uiImage: UIImage(named: "1BIG ERUPTION")!)
                    .resizable()
                    .frame(width: bigEraptionFrame.0, height: bigEraptionFrame.1)
                    .rotationEffect(.degrees(-20))
                    .offset(x: -50, y: bigEraptionYCoordinate)
                    .onAppear {
                        withAnimation(.easeIn(duration: 2).delay(13.5)) {
                            bigEraptionYCoordinate = -80
                        }
                        withAnimation(.easeIn(duration: 2).delay(15.5)) {
                            bigEraptionFrame = (100,0)
                            bigEraptionYCoordinate = 300
                        }
                    }
                Image(uiImage: UIImage(named: "1pizza")!)
                    .resizable()
                    .frame(width: bigPizzaFrame.0, height: bigPizzaFrame.1)
                    .rotationEffect(.degrees(bigPizzaRotationDegree))
                    .offset(x: bigPizzaXCoordinate, y: bigPizzaYCoordinate)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1).delay(13)) { // 17
                            bigPizzaYCoordinate = 200
                            bigPizzaRotationDegree = 0
                        }
                        withAnimation(.easeIn(duration: 1).delay(15.5)) { //21
                            bigPizzaFrame = (300,300)
                        }
                        withAnimation(.easeIn(duration: 0.5).delay(25)) { //23
                            bigPizzaRotationDegree = -30
                        }
                        withAnimation(.easeIn(duration: 0.5).delay(25.5)) { //24
                            bigPizzaXCoordinate = 400
                            bigPizzaRotationDegree = 200
                            
                            }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 25.5 ) {
                            willMoveToSecondScreen = true
                        }
                    }
                }
            .frame(width: 500, height: 700, alignment: .center)
            .fullScreenCover(isPresented: $willMoveToSecondScreen, content: {
                SecondSceneContentView()
            })
        }
    
    func playAudio() {
        if let audioURL = Bundle.main.url(forResource: "PIZZAMUSIC", withExtension: "m4a") {
            do {
                try self.audioPlayer = AVAudioPlayer(contentsOf: audioURL)
                self.audioPlayer?.numberOfLoops = 0
                self.audioPlayer?.play()
                
            } catch {
                print("Couldn't play audio. Error: \(error)")
            }
            
        } else {
            print("No audio file found")
        }
    }
}



// MARK: - Second Scene
public struct SecondSceneContentView: View {
    @State private var willMoveToThirdScreen = false
    @State private var offsetForBackground: CGFloat = 2100
    @State private var pizzaOffsetX: CGFloat = 140
    @State private var pizzaOffsetY: CGFloat = 140
    @State private var pizzaRotationEffect: CGFloat = 360
    @State private var pizzaFrameWidth: CGFloat = 80
    @State private var pizzaFrameHeight: CGFloat = 80
    @State private var earthFrameWidth: CGFloat = 450
    @State private var earthFrameHeight: CGFloat = 600
    @State private var earthBlur: CGFloat = 0
    @State private var earthScale: CGFloat = 0
    @State private var earthOffsetX: CGFloat = 0
    @State private var earthOffsetY: CGFloat = 0
    
    
   public var body: some View {
       NavigationView {
        ZStack {
            Image(uiImage: UIImage(named: "2SPACEBACKGROUND")!)
                .offset(x: 0, y: offsetForBackground)
                .onAppear {
                    withAnimation(.linear(duration: 20)) {
                        offsetForBackground = 1500
                    }
                }
            Image(uiImage: UIImage(named: "2WATER")!)
                    .resizable()
                    .frame(width: earthFrameWidth, height: earthFrameHeight, alignment: .center)
                    .blur(radius: earthBlur)
                    .offset(x: earthOffsetX, y: earthOffsetY)
                    
                    
            Image(uiImage: UIImage(named: "2EARTH")!)
                    .resizable()
                    .frame(width: earthFrameWidth, height: earthFrameHeight, alignment: .center)
                    .blur(radius: earthBlur)
                    .offset(x: earthOffsetX, y: earthOffsetY)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                            withAnimation(.linear(duration: 3)) {
                                earthBlur = 20
                                earthFrameWidth = 10000
                                earthFrameHeight = 11500
                                pizzaFrameWidth = 70
                                pizzaFrameHeight = 70
                                earthOffsetX = 500
                                earthOffsetY = 500
                            }
                        }
                    }
            
            Image(uiImage: UIImage(named: "2PIZZA")!)
                .resizable()
                .frame(width: pizzaFrameWidth, height: pizzaFrameHeight)
                .offset(x: pizzaOffsetX, y: pizzaOffsetY)
                .rotationEffect(Angle(degrees: pizzaRotationEffect))
                .onAppear {
                    withAnimation(.linear(duration: 6)) {
                        pizzaOffsetY = 5
                        pizzaOffsetX = 50
                        pizzaRotationEffect = -450
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation(.linear(duration: 3)) {
                                pizzaFrameWidth = 20
                                pizzaFrameHeight = 20
                            }
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6.5) {
                        willMoveToThirdScreen = true
                    }
                }
            
        }
        .frame(width: 500, height: 700)
        .fullScreenCover(isPresented: $willMoveToThirdScreen, content: {
            ThirdSceneContentView()
        })
       }
    }
}

struct ThirdSceneContentView: View {
    @State private var willMoveToFourthScreen = false
    
    @State private var pizzaOffsetX: CGFloat = -250
    @State private var pizzaOffsetY: CGFloat = 180
    
    @State private var pizzaRotationEffect: CGFloat = 0
    
    @State private var humanOffsetX: CGFloat = 350
    
    var body: some View {
        ZStack {
            Image(uiImage: UIImage(named: "3thirdBackground")!)
                .resizable()
                
            Image(uiImage: UIImage(named: "3sun")!)
                .resizable()
            
            Image(uiImage: UIImage(named: "3garden")!)
                .resizable()
            
            Image(uiImage: UIImage(named: "3buildings")!)
                .resizable()
            
            Image(uiImage: UIImage(named: "3firstHuman")!)
                .resizable()
                .offset(x: humanOffsetX, y: 80)
                .frame(width: 250, height: 350)
                .onAppear {
                    withAnimation(.linear(duration: 2)) {
                        humanOffsetX = 100
                    }
                    withAnimation(.linear(duration: 2).delay(12)) {
                        humanOffsetX = 350
                    }
                    
                }
            
            Image(uiImage: UIImage(named: "3pizza")!)
                .resizable()
                .frame(width: 150, height: 150)
                .rotationEffect(.degrees(pizzaRotationEffect))
                .offset(x: pizzaOffsetX, y: pizzaOffsetY)
                .onAppear {
                    withAnimation(.easeIn(duration: 2)) {
                        pizzaOffsetX = -120
                        pizzaRotationEffect = 360
                    }
                    withAnimation(.easeIn(duration: 2).delay(12)) {
                        pizzaOffsetX = -350
                        pizzaRotationEffect = 0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 13) {
                        willMoveToFourthScreen = true
                    }
                }
        }
        .frame(width: 500, height: 700)
        .fullScreenCover(isPresented: $willMoveToFourthScreen, content: {
            FourthSceneContentView()
        })
    }
}

struct FourthSceneContentView: View {
    @State private var willMoveToFifthScreen = false
    
    @State private var pizzaOffsetX: CGFloat = -350
    @State private var pizzaOffsetY: CGFloat = 180
    
    @State private var pizzaRotationEffect: CGFloat = 0
    
    @State private var humanOffsetX: CGFloat = 350
    
    var body: some View {
        ZStack {
            Image(uiImage: UIImage(named: "4background")!)
                .resizable()
            
            Image(uiImage: UIImage(named: "4sun")!)
                .resizable()
                
            Image(uiImage: UIImage(named: "4garden")!)
                .resizable()
            
            Image(uiImage: UIImage(named: "4houses")!)
                .resizable()
            
            Image(uiImage: UIImage(named: "4human")!)
                .resizable()
                .offset(x: humanOffsetX, y: 40)
                .frame(width: 400, height: 550)
                .onAppear {
                    withAnimation(.linear(duration: 2)) {
                        humanOffsetX = 0
                    }
                    withAnimation(.linear(duration: 1).delay(10)) {
                        humanOffsetX = 350
                    }
                }
            
            Image(uiImage: UIImage(named: "4pizza")!)
                .resizable()
                .frame(width: 150, height: 150)
                .rotationEffect(.degrees(pizzaRotationEffect))
                .offset(x: pizzaOffsetX, y: pizzaOffsetY)
                .onAppear {
                    withAnimation(.easeIn(duration: 2)) {
                        pizzaOffsetX = -120
                        pizzaRotationEffect = 360
                    }
                    withAnimation(.easeIn(duration: 1).delay(10)) {
                        pizzaOffsetX = -350
                        pizzaRotationEffect = 0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 11) {
                        willMoveToFifthScreen = true
                    }
                }
        }
        .frame(width: 500, height: 700)
        .fullScreenCover(isPresented: $willMoveToFifthScreen, content: {
            FifthSceneContentView()
        })
    }
}

struct FifthSceneContentView: View {
    @State private var willMoveToSixthScreen = false
    
    @State private var pizzaOffsetX: CGFloat = -350
    @State private var pizzaOffsetY: CGFloat = 230
    
    @State private var millOffsetX: CGFloat = 0
    @State private var millOffsetY: CGFloat = 0
    
    @State private var pizzaRotationEffect: CGFloat = 0
    
    @State private var humanOffsetX: CGFloat = 350
    
    @State private var millRorationEffect: CGFloat = 0
    
    var body: some View {
        ZStack {
            Image(uiImage: UIImage(named: "5background")!)
                .resizable()
            
            Image(uiImage: UIImage(named: "5mountains")!)
                .resizable()
                
            Image(uiImage: UIImage(named: "5ground")!)
                .resizable()
            
            Image(uiImage: UIImage(named: "5house")!)
                .resizable()
            
            Image(uiImage: UIImage(named: "5rotatingmill")!)
                .resizable()
                
            Image(uiImage: UIImage(named: "5person")!)
                .resizable()
                .offset(x: humanOffsetX, y: 60)
                .frame(width: 400, height: 550)
                .onAppear {
                    withAnimation(.linear(duration: 2)) {
                        humanOffsetX = 100
                    }
                    withAnimation(.linear(duration: 1).delay(10)) {
                        humanOffsetX = 350
                    }
                }
            
            Image(uiImage: UIImage(named: "5pizza")!)
                .resizable()
                .frame(width: 150, height: 150)
                .rotationEffect(.degrees(pizzaRotationEffect))
                .offset(x: pizzaOffsetX, y: pizzaOffsetY)
                .onAppear {
                    withAnimation(.easeIn(duration: 2)) {
                        pizzaOffsetX = -120
                        pizzaRotationEffect = 360
                    }
                    withAnimation(.easeIn(duration: 1).delay(10)) {
                        pizzaOffsetX = -350
                        pizzaRotationEffect = 0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 11) {
                        willMoveToSixthScreen = true
                    }
                }
            
        }
        .frame(width: 500, height: 700)
        .fullScreenCover(isPresented: $willMoveToSixthScreen, content: {
            SixthSceneContentView()
        })
    }
}

struct SixthSceneContentView: View {
    @State private var willMoveToSeventhScreen = false
    
    @State private var pizzaOffsetX: CGFloat = -190
    @State private var pizzaOffsetY: CGFloat = 230
    @State private var cloudsOffsetX: CGFloat = -500
    
    @State private var normPizzaOpacity: CGFloat = 1
    @State private var cutPizzaOpacity: CGFloat = 0
    
    @State private var tears1Opacity: CGFloat = 0
    @State private var tears2Opacity: CGFloat = 0
    @State private var tears3Opacity: CGFloat = 0
    @State private var tears4Opacity: CGFloat = 0
    
    @State private var firstHumanOpacity: CGFloat = 1
    @State private var secondHumanOpacity: CGFloat = 0
    @State private var thirdHumanOpacity: CGFloat = 0
    @State private var humanOffsetX: CGFloat = 380
    
    @State private var cloudsOpacity: CGFloat = 1
    
    @State private var sunOffsetY: CGFloat = 70
    
    var body: some View {
        ZStack {
            Image(uiImage: UIImage(named: "6background")!)
                .resizable()
            
            Image(uiImage: UIImage(named: "6movingclouds")!)
                .frame(width: 700, height: 500)
                .offset(x: cloudsOffsetX, y: 0)
                .opacity(cloudsOpacity)
                .onAppear {
                    withAnimation(.linear(duration: 25)) {
                        cloudsOffsetX = 550
                    }
                }
            
            Image(uiImage: UIImage(named: "6sun")!)
                .frame(width: 700, height: 500)
                .offset(x: 0, y: sunOffsetY)
                
            ZStack {
                Image(uiImage: UIImage(named: "6square")!)
                    .resizable()
                    .frame(width: 500, height: 900)
                
                Image(uiImage: UIImage(named: "6garbage")!)
                    .resizable()
                    .frame(width: 500, height: 700)
                    .offset(x: 0, y: 0)
            }
            
            ZStack {
            Image(uiImage: UIImage(named: "6sadpizza")!)
                .resizable()
                .frame(width: 150, height: 150)
                .offset(x: pizzaOffsetX, y: pizzaOffsetY)
                .opacity(normPizzaOpacity)
                .onAppear {
                    withAnimation(.linear(duration: 2)) {
                        tears1Opacity = 1.0
                        tears2Opacity = 0.0
                        tears3Opacity = 0.0
                        tears4Opacity = 0.0
                    }
                    withAnimation(.linear(duration: 2).delay(2)) {
                        tears1Opacity = 0.0
                        tears2Opacity = 1.0
                        tears3Opacity = 0.0
                        tears4Opacity = 0.0
                    }
                    withAnimation(.linear(duration: 2).delay(4)) {
                        tears1Opacity = 0.0
                        tears2Opacity = 0.0
                        tears3Opacity = 1.0
                        tears4Opacity = 0.0
                    }
                    withAnimation(.linear(duration: 2).delay(6)) {
                        tears1Opacity = 0.0
                        tears2Opacity = 0.0
                        tears3Opacity = 0.0
                        tears4Opacity = 1.0
                    }
                    withAnimation(.linear(duration: 2).delay(8)) {
                        tears1Opacity = 0.0
                        tears2Opacity = 0.0
                        tears3Opacity = 0.0
                        tears4Opacity = 0.0
                    }
                    withAnimation(.linear(duration: 8).delay(11)) {
                        pizzaOffsetY = 20
                        pizzaOffsetX = 0
                        humanOffsetX = 170
                    }
                    withAnimation(.linear(duration: 1).delay(29)) {
                        normPizzaOpacity = 0
                        cutPizzaOpacity = 1
                    }
                    withAnimation(.linear(duration: 1).delay(30)) {
                        firstHumanOpacity = 0.0
                        secondHumanOpacity = 1.0
                    }
                    
                    withAnimation(.linear(duration: 1).delay(33)) {
                        secondHumanOpacity = 0.0
                        thirdHumanOpacity = 1.0
                        cloudsOpacity = 0
                        sunOffsetY = -70
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 34) {
                        willMoveToSeventhScreen = true
                    }
                }
            
            Image(uiImage: UIImage(named: "6cutpizza")!)
                .resizable()
                .frame(width: 150, height: 200)
                .offset(x: pizzaOffsetX, y: pizzaOffsetY)
                .opacity(cutPizzaOpacity)
        }
            Image(uiImage: UIImage(named: "6tears1")!)
                .resizable()
                .frame(width: 150, height: 150)
                .opacity(tears1Opacity)
                .offset(x: -190, y: 230)
            
            Image(uiImage: UIImage(named: "6tears2")!)
                .resizable()
                .frame(width: 150, height: 150)
                .opacity(tears2Opacity)
                .offset(x: -190, y: 230)
            
            Image(uiImage: UIImage(named: "6tears3")!)
                .resizable()
                .frame(width: 150, height: 150)
                .opacity(tears3Opacity)
                .offset(x: -190, y: 230)
            
            Image(uiImage: UIImage(named: "6tears4")!)
                .resizable()
                .frame(width: 150, height: 150)
                .opacity(tears4Opacity)
                .offset(x: -190, y: 230)
            
            ZStack {
                Image(uiImage: UIImage(named: "6personbeforeeatingpizza")!)
                    .resizable()
                    .frame(width: 500, height: 600)
                    .offset(x: humanOffsetX, y: 0)
                    .opacity(firstHumanOpacity)
                
                Image(uiImage: UIImage(named: "6personeatingpizza")!)
                    .resizable()
                    .frame(width: 500, height: 600)
                    .offset(x: 170, y: 0)
                    .opacity(secondHumanOpacity)
                
                Image(uiImage: UIImage(named: "6personaftereatingpizza")!)
                    .resizable()
                    .frame(width: 500, height: 600)
                    .offset(x: 170, y: 0)
                    .opacity(thirdHumanOpacity)
                
            }
            
        }
        .frame(width: 500, height: 700)
        .fullScreenCover(isPresented: $willMoveToSeventhScreen, content: {
            SeventhSceneContentView()
        })
    }
}

struct SeventhSceneContentView: View {
    
    @State private var opacity: CGFloat = 0
    @State private var yPositionBg1: CGFloat = 0
    @State private var yPositionBg2: CGFloat = -1400
    @State private var endPizzaOpacity: CGFloat = 0
    @State private var allOpacity: CGFloat = 1
    
    var body: some View {
        
        ZStack {
            // Secound Background
            Image(uiImage: UIImage(named: "7endPizza")!)
                .resizable()
                .frame(width: 500, height: 300)
                
                .opacity(endPizzaOpacity)
            
            Image(uiImage: UIImage(named: "7ANIMATEDBACKGROUND")!)
                .scaledToFit()
                .frame(width: 500, height: 700)
                .position(CGPoint(x: 0, y: yPositionBg2))
                .opacity(allOpacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 30).delay(0)) {
                        yPositionBg2 = 0
                    }
                }
            
            VStack {
                ZStack {
                    
                    Image(uiImage: UIImage(named: "7WORLD1")!)
                        .resizable()
                        .frame(width: 500, height: 700)
                    
                    Image(uiImage: UIImage(named: "7WORLD2")!)
                        .resizable()
                        .frame(width: 500, height: 700)
                    
                    PizzaParty().frame(width: 400, height: 400, alignment: .bottom)
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1).delay(0)) {
                                opacity = 1
                            }
                            withAnimation(.linear(duration: 0.6).delay(7)) {
                                allOpacity = 0
                                endPizzaOpacity = 1
                            }
                        }
                }
                
                Text("IF YOU EVER FELT LIKE THIS PIZZA, DON'T WORRY AND DON'T GIVE UP. YOUR DAY WILL COME!")
                    .frame(width: 400, height: 100, alignment: .top)
                    .lineLimit(3)
                    .foregroundColor(.white)
                    .font(.system(size: 15, weight: .heavy))
                    .multilineTextAlignment(.center)
                
            }
            .opacity(allOpacity)
        }
        .frame(width: 500, height: 700)
        .background(.black)
    }
}

struct PizzaParty: View {
    @State private var rotation:Angle = .zero
    private let maxRotation = Angle.degrees(10)
    private let dancingDuration = 0.3
    
    
    var body: some View {
        Image(uiImage: UIImage(named: "7PIZZAFINAL1")!)
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            .position(CGPoint(x: 350, y: 0))
            .rotationEffect(rotation)
            .onAppear{
                withAnimation(.easeInOut(duration: dancingDuration).delay(0).repeatForever(autoreverses: true)) {
                    rotation = maxRotation
                }
            }
        
        Image(uiImage: UIImage(named: "7PIZZAFINAL2")!)
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            .position(CGPoint(x: 40, y: 40))
            .rotationEffect(rotation)
            .onAppear{
                withAnimation(.easeInOut(duration: dancingDuration).delay(0).repeatForever(autoreverses: true)) {
                    rotation = maxRotation
                }
            }
        
        Image(uiImage: UIImage(named: "7pizzaPIZZAFINAL3")!)
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            .position(CGPoint(x: 350, y: 350))
            .rotationEffect(rotation)
            .onAppear{
                withAnimation(.easeInOut(duration: dancingDuration).delay(0).repeatForever(autoreverses: true)) {
                    rotation = maxRotation
                }
            }
    }
}

PlaygroundPage.current.setLiveView(ContentView())
