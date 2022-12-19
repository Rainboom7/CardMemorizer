//
//  EmojiMemoryGame.swift
//  CardMemorizer
//
//  Created by Admin on 16.11.2022.
//

import Foundation


class EmojiMemoryGame : ObservableObject{
    
    var theme: Theme
    var startNewGame : ()->Void = {}
    
    @Published var model: MemoryGame<String>!

    init(theme: Theme) {
        self.theme = theme
        self.makeGame(numberOfPairs: theme.content.count)
    }
    
    init(theme: Theme, numberOfPairs:Int, startNewGame: @escaping ()->Void) {
        self.theme = theme
        self.makeGame(numberOfPairs: numberOfPairs)
        self.startNewGame = startNewGame
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
       startNewGame()
    }
    
    var hints:Int {
        model.hints
    }
    
    func useHint() {
        if(model.hints>0){
            model.startUsingHint()
            var myself = self
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                myself.stopUsingHint()
            }
        }
    }
    
    private func stopUsingHint(){
        model.endUsingHint()
    }
    
    private func makeNewGame()->Void{
        let newTheme = ThemeFactory.randomBuild();
        self.makeGame(numberOfPairs: newTheme.content.count)
    }

    private func makeGame(numberOfPairs:Int) {
        let content = theme.content
        model = MemoryGame(numberOfPairsOfCards: numberOfPairs) { (index) -> String in
            return content[index]
        }
    }
}
