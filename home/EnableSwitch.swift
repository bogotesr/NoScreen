//
//  EnableView.swift
//  NoScreen
//
//  Created by Joshua Laymon on 6/4/25.
//

import SwiftUI
import WidgetKit

struct EnableSwitch: View {
    @Binding var app: AppList
    @Binding var allApps: [AppList]
    
    var body: some View {
        Toggle(isOn: $app.enabled) {
            Text(app.name)
        }
        .onChange(of: app.enabled) {
            saveAppList(allApps)
        }
    }
}

//#Preview {
//    EnableSwitch(isEnabled: .constant(true), name: "Discord")
//}
