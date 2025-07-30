//
//  AddAppSheet.swift
//  NoScreen
//
//  Created by bogotesr on 7/29/25.
//

import SwiftUI

struct AddAppSheet: View {
    @State private var apps: [AppList] = []
        .filter{ !$0.enabled }
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List{
            ForEach($apps) { $app in
                HStack {
                    Text(app.name)
                    Spacer()
                }
                .onTapGesture {
                    print(app.name)
                    app.enabled.toggle()
                    app.position = nextPosition()
                    saveAppList(apps + loadAppList(1))
                    dismiss()
                }
            }
        }
        .onAppear {
            apps = loadFullList().filter{ !$0.enabled }
        }
    }
}

#Preview {
    AddAppSheet()
}
