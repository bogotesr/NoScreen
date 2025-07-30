//
//  EditAppListView.swift
//  NoScreen
//
//  Created by bogotesr on 7/28/25.
//

import SwiftUI

struct EditAppListView: View {
    @State private var apps: [AppList] = loadAppList(1)
        .sorted { $0.position < $1.position }
    @State private var showingAddAppSheet = false
    
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            VStack(spacing:0) {
                List {
                    ForEach($apps) { $app in
                        HStack {
                            Text(app.name)
                            Spacer()
                            Text(String(app.position + 1))
                        }
                        
                    }
                    .onMove(perform: moveItem)
                    .onDelete(perform: removeItem)
                }
                .onAppear { apps = loadAppList(1) }
                .padding(.top, -18.0)
                
                HStack {
                    Button {
                        showingAddAppSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .padding(.all, 5.0)
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(.white)
                            .background(Color(.systemBlue))
                            .clipShape(Circle())
                        Text("Add app")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.blue)
                    }
                    .padding([.top, .leading, .bottom])
                    Spacer()
                }
                .background(Color(.systemBackground))
            }
            .padding(0)
        }
        .sheet(isPresented: $showingAddAppSheet, onDismiss: { apps = loadAppList(1) })  {
            AddAppSheet()
        }
        .navigationTitle("Edit Widgets")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
        }
    }
    
    //functions for practice and maybe I'll add more logic later?
    func moveItem(from source: IndexSet, to destination: Int) {
        apps.move(fromOffsets: source, toOffset: destination)
        
        for index in apps.indices {
            apps[index].position = index
        }
        saveAppList(apps)
    }
    
    func removeItem(at offsets: IndexSet) {
        var newList = loadFullList()
        
        for offset in offsets {
            let removedApp = apps[offset]
            if let newIndex = newList.firstIndex(where: { $0.id == removedApp.id }) {
                newList[newIndex].enabled = false
            }
        }
        saveAppList(newList)
        apps.remove(atOffsets: offsets)
        print(newList)
    }
}

#Preview {
    EditAppListView()
}
