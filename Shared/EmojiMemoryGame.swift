//
//  EmojiMemoryGame.swift
//  CardMemorizer
//
//  Created by Admin on 16.11.2022.
//

import Foundation


class EmojiMemoryGame : ObservableObject{
    
    var theme: Theme
    @Published var model: MemoryGame<String>!

    init(theme: Theme) {
        self.theme = theme
        self.makeGame()
    }

    var cards: [MemoryGame<String>.Card] {
        model.cards
    }

    var score: Int {
        model.score
    }

    func choose(card: MemoryGame<String>.Card) {
        model.choose(card)
    }

    func newGame() {
        self.theme = ThemeFactory.randomBuild()
        self.makeGame()
    }

    private func makeGame() {
        let content = theme.content
        model = MemoryGame(numberOfPairsOfCards: content.count) { (index) -> String in
            return content[index]
        }
    }
}
