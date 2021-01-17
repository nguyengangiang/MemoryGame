//
//  MemoryGame.swift
//  Memorize
//
//  Created by Giang Nguyenn on 12/25/20.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent>: Codable where CardContent: Equatable, CardContent: Codable {
    private(set) var cards: [Card]
    private(set) var name: String
    private(set) var color: UIColor.RGB
    private(set) var score: Int

    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter{cards[$0].isFaceUp}.only
        }
        set {
            for index in 0 ..< cards.count {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isMatched, !cards[chosenIndex].isFaceUp {
            if let potentialMatched = indexOfTheOneAndOnlyFaceUpCard {
                if (cards[potentialMatched].content == cards[chosenIndex].content) {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatched].isMatched = true
                    score += 2

                } else {
                    if cards[chosenIndex].isSeen == true {
                        score -= 1
                    }
                    if (cards[potentialMatched].isSeen == true){
                        score -= 1
                    }
                }
                cards[chosenIndex].isFaceUp = true
                cards[chosenIndex].isSeen = true
                cards[potentialMatched].isSeen = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    var json: Data? {
        try? JSONEncoder().encode(self)
    }
    
    init (numberOfPairsOfCards: Int, themeName: String, color: UIColor.RGB, createContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0 ..< numberOfPairsOfCards {
            cards.append(Card(content: createContent(pairIndex), id: pairIndex * 2))
            cards.append(Card(content: createContent(pairIndex), id: pairIndex * 2 + 1))
        }
        cards.shuffle()
        name = themeName
        self.color = color
        score = 0
    }
    
    struct Card: Identifiable, Codable{
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var content: CardContent
        var id: Int
        var isSeen: Bool = false
        
        //MARK: Bonus Time
        
        // this could give matching bonus points
        // if the user matches the card
        // before a certain amount of time passes during which the card is face up
        
        // can be zero which means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 6
        
        // how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        // the last time this card was turned face up (and is still face up)
        var lastFaceUpDate : Date?
        // the accumulated time this card has been face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            return max(0, bonusTimeLimit - faceUpTime)
        }
        
        // percentage of the bonus time remaining
        var bonusRemaining: Double {
            return (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        // whether we are currently face up, unmatched and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            print("start using bonus time")
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        // called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}
