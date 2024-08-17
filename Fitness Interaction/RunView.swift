//
//  RunView.swift
//  Fitness Interaction
//
//  Created by Afeez Yunus on 14/08/2024.
//

import SwiftUI
import RiveRuntime

struct RunView: View {
    @State var activities:String
    @State var kcal = "100"
    @State var distance = "1.4"
    @State var time = ""
    @State var split = "1.0"
    @State var bpm = "72"
    @State var pace = "12’50"
    @State private var elapsedTime: TimeInterval = 0
    @State private var timer: Timer?
    @State var goBack:()->Void
    var nameSpace:Namespace.ID
    @State var riveAnimation = RiveViewModel(fileName: "fitness",fit: .contain, artboardName: "Walking")
    @State var isTimerPaused = false
    
    
    
    var body: some View {
        VStack(spacing:24){
            ZStack{
                Text(activities.capitalized)
                    .font(.title3)
                    .fontWeight(.medium)
                HStack{
                    Button(action: {
                        goBack()
                        
                    }, label: {
                        Image(systemName: "arrow.left")
                            .padding(12)
                            .foregroundStyle(Color(.white).opacity(0.6))
                            .background(Color("object"))
                            .clipShape(RoundedRectangle(cornerRadius: 24 ))
                    })
                    Spacer()
                    
                }
            }
            riveAnimation.view()
                .frame(height: 100)
                .matchedGeometryEffect(id: activities, in: nameSpace)
                .onAppear{
                    riveAnimation.triggerInput(activities)
                }
                .onChange(of: isTimerPaused) { oldValue, newValue in
                    if isTimerPaused {
                        riveAnimation.triggerInput("warming up")
                    } else {
                        riveAnimation.triggerInput(activities)
                    }
                }
            VStack (spacing:4){
                Text("Workout Time")
                    .fontWeight(.medium)
                    .foregroundStyle(.white).opacity(0.6)
                Text(formattedElapsedTime())
                    .font(.system(size: 48))
                    .animation(.spring, value: formattedElapsedTime())
                    .contentTransition(.numericText())
            }
            Spacer()
            HStack{
                Stat(statViz: "distance", activityStat: distance, unit: "km", value: "Distance")
                Spacer()
                Stat(statViz: "cal", activityStat: kcal, unit: "kcal", value: "Total calories")
                Spacer()
                Stat(statViz: "bpm", activityStat: bpm, unit: "bpm", value: "Heart rate")
            }
            
            HStack{
                
                Spacer()
                Stat(statViz: "pace", activityStat: pace, unit: "/km", value: "Pace")
                Spacer()
                Stat(statViz: "splits", activityStat: split, unit: "", value: "Splits")
                Spacer()
            }
            Spacer()
            Button(action: {
                isTimerPaused.toggle()
                if isTimerPaused {
                    // Pause the timer
                    timer?.invalidate()
                    timer = nil
                } else {
                    // Resume the timer
                    startTimer()
                }
            }, label: {
                Image(systemName:isTimerPaused ? "play.fill" : "pause.fill")
                    .padding(32)
                    .background(.white)
                    .foregroundStyle(Color("Background"))
                    .clipShape(Circle())
            })
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "xmark")
                    .padding(16)
                    .background(Color("red bg"))
                    .foregroundStyle(Color(.white).opacity(0.6))
                    .clipShape(Circle())
            })
            
            Text("Long press to end workout")
                .foregroundStyle(Color(.white).opacity(0.6))
                .font(.caption)
        } .preferredColorScheme(.dark)
            .padding(.horizontal, 16)
            .background(Color("Background")).onAppear {
                startTimer()
            }
            .onDisappear {
                timer?.invalidate()
            }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            elapsedTime += 0.1
        }
    }
    
    func formattedElapsedTime() -> String {
        let hours = Int(elapsedTime) / 3600
        let minutes = (Int(elapsedTime) % 3600) / 60
        let seconds = Int(elapsedTime) % 60
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}



struct Stat: View {
    
    let statViz:String
    let activityStat:String
    let unit:String
    let value:String
    var body: some View {
        VStack (spacing:4){
            Image(statViz)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 24)
                .padding(.bottom, 8)
            Text("\(activityStat) \(unit)")
                .font(.system(size: 18))
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
            Text(value)
                .font(.system(size: 14))
                .fontWeight(.medium)
                .foregroundStyle(.white).opacity(0.6)
        }
    }
}
