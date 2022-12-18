//
//  GameFactory.swift
//  CardMemorizer
//
//  Created by Admin on 21.11.2022.
//
import Foundation

class GameFactory {

    static func createMemoryGame(theme: ThemeFactory.ThemeOption,difficutly:DifficultyFactory.DifficutlyOption,startNewGame: @escaping ()->Void) -> EmojiMemoryGame {
        EmojiMemoryGame(theme: ThemeFactory.build(theme: theme),
                        numberOfPairs: DifficultyFactory.build(difficultyOption: difficutly).numberOfPairs,
                        startNewGame: startNewGame
        )
    }
}
