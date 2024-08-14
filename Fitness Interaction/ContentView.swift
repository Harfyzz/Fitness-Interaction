//
//  ContentView.swift
//  Fitness Interaction
//
//  Created by Afeez Yunus on 14/08/2024.
//

import SwiftUI

struct ContentView: View {
    @State var searchText:String = ""
    var body: some View {
        VStack (spacing:16){
            ZStack{
                Text("Start Workout")
                    .font(.title3)
                    .fontWeight(.medium)
                HStack{
                    Button(action: {}, label: {
                        Image(systemName: "arrow.left")
                            .padding(12)
                            .foregroundStyle(Color(.white).opacity(0.6))
                            .background(Color("object"))
                            .clipShape(RoundedRectangle(cornerRadius: 24 ))
                    })
                    Spacer()
                    
                }
            }
            HStack{
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Color(.white).opacity(0.3))
                TextField("Search Workout", text: $searchText)
            }.padding(8)
            .background(Color("secondary"))
            .clipShape(RoundedRectangle(cornerRadius: 64))
            .overlay {
                RoundedRectangle(cornerRadius: 64)
                    .stroke(Color("object"), lineWidth: 1)
            }
            HStack{
                Spacer()
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                Spacer()
        }
            Text("Hello, world!")
            Spacer()
        }
        .padding()
        .background(Color("Background"))
        .preferredColorScheme(.dark)
     
        
    }
}

#Preview {
    ContentView()
}
