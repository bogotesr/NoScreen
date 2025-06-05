//
//  ContentView.swift
//  home
//
//  Created by Joshua Laymon on 4/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var apps: [AppList] = loadFullList()
    
    var body: some View {
        VStack {
            ForEach($apps) { $app in
                EnableSwitch(app: $app, allApps: $apps)
            }
        
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
