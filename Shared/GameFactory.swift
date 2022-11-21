//
//  GameFactory.swift
//  CardMemorizer
//
//  Created by Admin on 21.11.2022.
//
import Foundation

class GameFactory {

    static func createMemoryGame() -> EmojiMemoryGame {
        EmojiMemoryGame(theme: ThemeFactory.randomBuild())
    }

    static func createMemoryGame(theme: ThemeFactory.ThemeOption) -> EmojiMemoryGame {
        EmojiMemoryGame(theme: ThemeFactory.build(theme: theme))
    }
}
