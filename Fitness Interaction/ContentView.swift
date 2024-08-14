//
//  ContentView.swift
//  Fitness Interaction
//
//  Created by Afeez Yunus on 14/08/2024.
//

import SwiftUI

struct ContentView: View {
    @State var searchText:String = ""
    @State var activities = ["crunches", "cycling", "hiking", "running", "skipping", "stretching", "swimming", "walking", "weight lifting"]
    var body: some View {
        VStack (spacing:24){
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
            ScrollView {
                VStack (spacing:4){
                    ForEach (activities, id: \.self) { activity in
                        HStack{
                            Image(activity)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 32)
                            Text(activity)
                            Spacer()
                        }
                        .padding(.vertical, 16)
                        .padding(.horizontal, 8)
                        .foregroundStyle(Color(.white))
                        .background(Color("secondary"))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }.clipShape(RoundedRectangle(cornerRadius: 16))
                .scrollIndicators(.hidden)
            
        }
        .padding()
        .background(Color("Background"))
        .preferredColorScheme(.dark)
     
        
    }
}

#Preview {
    ContentView()
}
