//
//  ActivityScroll.swift
//  Fitness Interaction
//
//  Created by Afeez Yunus on 17/08/2024.
//

import SwiftUI
import RiveRuntime

struct ActivityScroll: View {
    @State var fitnessImagery = RiveViewModel(fileName: "fitness",fit: .contain, artboardName: "Walking")
    @State var selectedItem = "warming up"
    let content = ContentView()
    
    var body: some View {
        VStack{
            ZStack{
                Text("Select Activity")
                    .font(.title3)
                    .fontWeight(.medium)
                HStack{
                    Button(action: {
                        
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
            Spacer()
            fitnessImagery.view()
                .frame(width: 300, height: 300)
                .onAppear{
                    fitnessImagery.triggerInput("warming up")
                }
            VStack(spacing:16){
            Text(selectedItem.capitalized)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .contentTransition(.numericText())
                .animation(.easeInOut, value: selectedItem)
            Picker("", selection: $selectedItem) {
                ForEach (content.activities, id: \.self) { activity in
                    Text(activity.capitalized)
                }
                .onChange(of: selectedItem) { oldValue, newValue in
                    fitnessImagery.triggerInput(selectedItem)
                }
            }.pickerStyle(.wheel)
                    .padding()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
        }
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                HStack{Spacer()
                    Text("Continue")
                        .padding()
                        .fontWeight(.medium)
                    Spacer()
                }.foregroundStyle(Color("Background"))
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 64))
            })
            Spacer()
            
        }.padding(.horizontal, 16)
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ActivityScroll()
}
