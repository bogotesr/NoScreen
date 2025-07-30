//
//  ContentView.swift
//  home
//
//  Created by Joshua Laymon on 4/8/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationLink(destination: EditAppListView()) {
            Text("Edit Widget")
        }
    }
}



#Preview {
    ContentView()
}
