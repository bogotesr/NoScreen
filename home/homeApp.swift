//
//  homeApp.swift
//  home
//
//  Created by Joshua Laymon on 4/8/25.
//

import SwiftUI

@main
struct homeApp: App {
    init() {
        ensureCopy()
        mergeAppLists()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    print("received: \(url.absoluteString)")
                    
                    UIApplication.shared.open(url)
                }
        }
    }
}
