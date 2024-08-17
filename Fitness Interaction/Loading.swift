//
//  Loading.swift
//  Fitness Interaction
//
//  Created by Afeez Yunus on 14/08/2024.
//

import SwiftUI
import RiveRuntime

struct Loading: View {
    
    @State var activities:String
    @State var trim = false
    @State private var countdown = 3
    @State private var showNextView = false
    @Binding var page:pages
    var nameSpace:Namespace.ID
    @State var warmup = RiveViewModel(fileName: "fitness", fit: .contain, artboardName: "Walking")
    
    var body: some View {
        VStack{
            Spacer()
                .frame(height: 32)
            warmup.view()
                .frame(height: 100)
                .matchedGeometryEffect(id: activities, in: nameSpace)
                .onAppear{
                    warmup.triggerInput("warming up")
                }
            Spacer()
            ZStack{
                Circle()
                    .foregroundStyle(Color("Background"))
                    .overlay {
                        Circle()
                            .trim(from: 0, to: trim ? 0 : 1)
                            .stroke(lineWidth: 8)
                            .frame(height: 280)
                            .foregroundStyle(Color("accent"))
                            .rotationEffect(.degrees(270))
                    }
                Text("\(countdown)")
                    .font(.system(size: 72))
                    .fontWeight(.semibold)
                    .animation(.spring, value: countdown)
                    .contentTransition(.numericText())
                    .frame(width:228, height: 228)
                    .background(Color("secondary bg"))
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(lineWidth: 2)
                            .foregroundStyle(Color("border"))
                            .rotationEffect(.degrees(270))
                    }
            }
            Spacer()
            Text("Get Ready...")
                .foregroundStyle(.white).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
        }.preferredColorScheme(.dark)
            .background(Color("Background"))
            .onAppear{
                startCountdown()
                withAnimation(.easeIn(duration: 3)) {
                    trim = true
                }
            }
            .onDisappear{
                countdown = 3
                
            }
    }
    func startCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if countdown > 1 && page == .loading{
                
                countdown -= 1
                
            } else if countdown == 1 {
                withAnimation {
                    page = .run
                }
                
            }
            else {
                timer.invalidate()
                
            }
        }
    }
}

