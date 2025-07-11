//
//  FileManager.swift
//  NoScreen
//
//  Created by Joshua Laymon on 6/4/25.
//

import Foundation
import WidgetKit

func ensureCopy() {
    guard let sharedURL = sharedAppListURL() else {return}
    
    if FileManager.default.fileExists(atPath: sharedURL.path) {
        print("file already exists")
        return
    }
    
    guard let bundleURL = Bundle.main.url(forResource: "AppList", withExtension: "json") else {
        print("AppList.json not in bundle")
        return
    }
    
    do {
        try FileManager.default.copyItem(at: bundleURL, to: sharedURL)
    } catch {
        print("couldn't copy \(error)")
    }
}

func sharedAppListURL() -> URL? {
    FileManager.default
        .containerURL(forSecurityApplicationGroupIdentifier: "group.bogotesr.home")?
        .appendingPathComponent("AppList.json")
}

func loadAppList(_ widgetNum: Int) -> [AppList] {
    guard let url = sharedAppListURL() else {
        return []
    }
    
    do {
        let data = try Data(contentsOf:url)
        let fullList = try JSONDecoder().decode([AppList].self, from: data)
        let newList = fullList
            .filter { $0.enabled }
            .sorted { $0.position < $1.position }
            .filter { $0.position >= 5*(widgetNum-1) }
            .filter { $0.position <= 5*widgetNum }
        print(newList)
        return newList
    } catch {
        print("Couldn't parse json \(error)")
        return []
    }
}

func loadFullList() -> [AppList] {
    guard let url = sharedAppListURL(),
          let data = try? Data(contentsOf: url),
          let fullList = try? JSONDecoder().decode([AppList].self, from: data) else {
        return []
    }
    return fullList
}

func saveAppList(_ apps: [AppList]) {
    guard let url = sharedAppListURL() else { return }
    
    do {
        let data = try JSONEncoder().encode(apps)
        try data.write(to: url)
        WidgetCenter.shared.reloadAllTimelines()
    } catch {
        print("failed to save json \(error)")
    }
}

func mergeAppLists() {
    guard let sharedURL = sharedAppListURL(),
          let bundleURL = Bundle.main.url(forResource: "AppList", withExtension: "json") else {
        return
    }
    
    do {
        let sharedData = try Data(contentsOf: sharedURL)
        var sharedList = (try JSONDecoder().decode([AppList].self, from: sharedData))
        
        let bundleData = try Data(contentsOf: bundleURL)
        let bundleList = (try JSONDecoder().decode([AppList].self, from: bundleData))
        
        let existingIDs = Set(sharedList.map { $0.id })
        let newItems = bundleList.filter { !existingIDs.contains($0.id)}
        
        if !newItems.isEmpty {
            sharedList.append(contentsOf: newItems)
            let newData = try JSONEncoder().encode(sharedList)
            try newData.write(to: sharedURL)
        }
    } catch {
        print("couldn't merge JSONs \(error)")
    }
}
