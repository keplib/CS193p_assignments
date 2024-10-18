//
//  Theme.swift
//  assignment1
//
//  Created by Balázs Képli on 17/10/24.
//

import Foundation
import SwiftUI


struct Theme<Content> {
    let themeName: String
    var setOfThemeEmojis: Array<Content>
    var themeColor: Color
    var numberOfPairs: Int
}
