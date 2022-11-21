//
//  Theme.swift
//  CardMemorizer
//
//  Created by Admin on 21.11.2022.
//

import UIKit

protocol Theme {
    var content: [String] { get }
    var cardColor: UIColor { get }
    var name: String { get }
}

class ThemeFactory {

    enum ThemeOption: CaseIterable {
        case none
        case love
        case vegetables
        case cold
    }
    
    static func randomBuild() -> Theme {
        let randomFactor = Int.random(in: 0..<ThemeOption.allCases.count)
        let option = ThemeOption.allCases[randomFactor]
        return build(theme: option)
    }

    static func build(theme: ThemeOption) -> Theme {
        switch theme {
        case .love: return LoveTheme()
        case .vegetables: return VegetablesTheme()
        case .cold: return ColdTheme()
        default: return DefaultTheme()
        }
    }
}

struct DefaultTheme: Theme {
    var content: [String] = ["A", "B", "C", "D"]
    var cardColor: UIColor = .black
    var name: String = "Default"
}

struct LoveTheme: Theme {
    var content: [String] = ["🥰","😍","🤩","👩‍❤️‍👩"]
    var cardColor: UIColor = .systemPink
    var name: String = "Love"
}

struct VegetablesTheme: Theme {
    var content: [String] = ["🍎", "🍆", "🍣", "🗿"]
    var cardColor: UIColor = .green
    var name: String = "Vegetables"
}

struct ColdTheme: Theme {
    var content: [String] = ["🧊", "🥶", "⛄️", "⛷"]
    var cardColor: UIColor = .blue
    var name: String = "Cold"
}
