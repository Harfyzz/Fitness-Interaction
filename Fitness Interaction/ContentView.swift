//
//  ContentView.swift
//  Fitness Interaction
//
//  Created by Afeez Yunus on 14/08/2024.
//

import SwiftUI
import RiveRuntime

enum pages {
    case list
    case loading
    case run
}

struct ContentView: View {
    @State var searchText:String = ""
    @State var activities = ["warm up","crunches", "cycling", "hiking", "outdoor run", "skipping", "indoor walk", "swimming", "outdoor walk", "weight-lifting"]
    @State var page:pages = .list
    @State var selectedSport = ""
    @Namespace var animate
    @Namespace var playButton
    @State var fitnessIcon = RiveViewModel(fileName: "fitness", fit: .contain, artboardName: "Walking")
    
    var body: some View {
        if page == .list {
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
                    .background(Color("secondary bg"))
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
                                    .frame(width:32, height: 32)
                                    .matchedGeometryEffect(id: activity, in: animate)
                                Text(activity.capitalized)
                                    .textInputAutocapitalization(.words)
                                Spacer()
                            }
                            .padding(.vertical, 16)
                            .padding(.horizontal, 8)
                            .foregroundStyle(Color(.white))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .onTapGesture {
                                selectedSport = activity
                                withAnimation {
                                    page = .loading
                                }
                                
                            }
                        }
                    }
                }.clipShape(RoundedRectangle(cornerRadius: 16))
                    .scrollIndicators(.hidden)
                
            }
            .padding()
            .background(Color("Background"))
            .preferredColorScheme(.dark)
            
            
        }
        else if page == .loading {
            Loading(activities: selectedSport, page: $page, nameSpace: animate)
        } else if page == .run {
            RunView(activities: selectedSport, goBack: {
                withAnimation {
                    page = .list
                }
                
            }, nameSpace: animate)
        }
    }
}

#Preview {
    ContentView()
}
