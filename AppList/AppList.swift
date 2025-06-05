//
//  AppList.swift
//  NoScreen
//
//  Created by Joshua Laymon on 6/4/25.
//

import Foundation

struct AppList: Codable, Hashable, Identifiable {
    var id: Int
    var name: String
    var scheme: String
    var enabled: Bool
    var position: Int
}
