//
//  ContentView.swift
//  home
//
//  Created by Joshua Laymon on 4/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var apps: [AppList] = loadFullList()
        .sorted { $0.position < $1.position }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    print("hello")
                }, label: {
                    Image(systemName: "plus")
                })
                Spacer()
                EditButton()
            }
            .frame(height: 20)
            .padding([.top, .leading, .trailing])
            
            List {
                ForEach($apps) { $app in
                    EnableSwitch(app: $app, allApps: $apps)
                }
                .onMove(perform: moveItem)
            }
            .padding()
        }
    }
    
    func moveItem(from source: IndexSet, to destination: Int) {
        apps.move(fromOffsets: source, toOffset: destination)
        
        for index in apps.indices{
            apps[index].position = index + 1
        }
        saveAppList(apps)
    }
}



#Preview {
    ContentView()
}
