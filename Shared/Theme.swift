//
//  Theme.swift
//  CardMemorizer
//
//  Created by Admin on 21.11.2022.
//

import UIKit
import SwiftUI

protocol Theme {
    var content: [String] { get }
    var cardColor: UIColor { get }
    var pieColor: UIColor { get }
    var name: String { get }
}

class ThemeFactory {

    enum ThemeOption: CaseIterable {
        case none
        case love
        case food
        case cold
        var description:String{
            get{
                switch self {
                case .none:
                return "Letters [A,B,C]"
                case .love:
                return "Love [🥰,💕,💌]"
                case .food:
                return "Food [🥒,🧅,🥕]"
                case .cold:
                return "Cold [🧊,🥶,⛷]"
                }
            }
        }
        var name:String{
            get{
                switch self {
                case .none:
                return "Default"
                case .love:
                return "Love"
                case .food:
                return "Food"
                case .cold:
                return "Cold"
                }
            }
        }
    }
    
    static func randomBuild() -> Theme {
        let randomFactor = Int.random(in: 0..<ThemeOption.allCases.count)
        let option = ThemeOption.allCases[randomFactor]
        return build(theme: option)
    }

    static func build(theme: ThemeOption) -> Theme {
        switch theme {
        case .love: return LoveTheme()
        case .food: return VegetablesTheme()
        case .cold: return ColdTheme()
        default: return DefaultTheme()
        }
    }
}

struct DefaultTheme: Theme {
    var content: [String] = ["A", "B", "C", "D", "E", "F", "G","H","I","J","K","L"]
    var cardColor: UIColor = .black
    var pieColor: UIColor = .white
    var name: String = "Default"
}

struct LoveTheme: Theme {
    var content: [String] = ["🥰","😍","🤩","👩‍❤️‍👩","💕", "💌","💟","😻","😘","💘","💔","🖤","💒"]
    var cardColor: UIColor = .systemPink
    var pieColor: UIColor = .red
    var name: String = "Love"
}

struct VegetablesTheme: Theme {
    var content: [String] = ["🍎", "🍆", "🥒", "🥕","🍊","🌽","🥬", "🥔", "🍞", "🥗","🧅","🍖"]
    var cardColor: UIColor = .green
    var pieColor : UIColor = .yellow
    var name: String = "Food"
}

struct ColdTheme: Theme {
    var content: [String] = ["🧊", "🥶", "⛄️", "⛷","❄️","🌲","🧥","🀩","🧊","⛸️","🏂","🍨"]
    var cardColor: UIColor = .blue
    var pieColor: UIColor = .systemIndigo
    var name: String = "Cold"
}
