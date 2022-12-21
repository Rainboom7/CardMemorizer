//
//  MemoryGame.swift
//  CardMemorizer
//
//  Created by Admin on 15.11.2022.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    
    let matchScore = 10
    let unmatchScore = -1
    
    private(set) var score = 0
    private (set) var hints = 1
    private(set) var cards: Array<Card>
    private var hintTimePassed = false;
    private var hintTimeActive = false;
    
    private var onlyFaceUpCardIndex : Int?{
    get { cards.indices.filter ({ cards[$0].isFaceUp}).oneAndOnly }
    set { cards.indices.forEach{ cards[$0].isFaceUp = ($0 == newValue) } }
}
    
  public mutating func choose(_ card: Card)  {
    
    if(hintTimeActive){
        return
    }
    
    guard let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) ,
          !cards[chosenIndex].isFaceUp,
          !cards[chosenIndex].isMatched else {return}

        if let potentialMatchIndex = onlyFaceUpCardIndex {
            if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                cards[chosenIndex].isMatched = true
                cards[potentialMatchIndex].isMatched = true
                score += Int(Double(matchScore) * cards[potentialMatchIndex].bonusRemaining * cards[chosenIndex].bonusRemaining)
            }else{
                score += unmatchScore
            }
            cards[chosenIndex].isFaceUp=true
        } else{
            onlyFaceUpCardIndex = chosenIndex
        }
    
   }
    
    func index(of card:Card) ->Int?{
        for index in 0..<cards.count{
            if cards[index].id == card.id{
                return index
            }
        }
        return nil
    }
    
    public mutating func endUsingHint(){
        hintTimePassed = true
        hintTimeActive = false;
        flipAllCardsForHint(faceUp: false)
        hintTimeActive = false;
    }
    public mutating func startUsingHint(){
        hintTimeActive=true
        flipAllCardsForHint(faceUp: true)
        hints=hints-1
    }
    private  mutating func flipAllCardsForHint(faceUp:Bool){
        cards.indices.forEach{
            cards[$0].isFaceUp = faceUp
            cards[$0].usingHintTime = faceUp
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int)-> CardContent) {
        cards = (0..<numberOfPairsOfCards).flatMap{pairIndex in
        [Card(content: createCardContent(pairIndex), id: pairIndex*2),
         Card(content: createCardContent(pairIndex), id: pairIndex*2+1)]
        }
        cards.shuffle()
    }
    
}

extension Array{
    var oneAndOnly : Element? {
        if self.count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}


extension MemoryGame {
    struct Card: Identifiable {
        var isFaceUp = false {
            didSet {
                if(usingHintTime){
                    return;
                }
                
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var content: CardContent
        var id: Int
                
        var bonusTimeLimit: TimeInterval = 6
        var usingHintTime = false;
        
        private var faceUpTime: TimeInterval {
            if let date = lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(date)
            }
            
            return pastFaceUpTime
        }
        
        var lastFaceUpDate: Date?
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            !usingHintTime && isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}
