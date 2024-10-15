//
//  assignment1App.swift
//  assignment1
//
//  Created by Balázs Képli on 16/9/24.
//

import SwiftUI

@main
struct assignment1App: App {
    var body: some Scene {
        WindowGroup {
            ContentView(cardCount: 3, themeColor: .red, vm: MemoryGameVM())
        }
    }
}
