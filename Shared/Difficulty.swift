//
//  Difficulty.swift
//  CardMemorizer
//
//  Created by Admin on 18.12.2022.
//

import Foundation

protocol Difficulty {
    var numberOfPairs: Int { get }
    var name: String { get }
}

class  DifficultyFactory{
    
    enum DifficutlyOption: CaseIterable {
        case easy
        case medium
        case hard
        var description:String{
            get{
                switch self {
                case .easy:
                return "Easy"
                case .medium:
                return "Medium"
                case .hard:
                return "Hard"
                }
            }
        }
    }
    
    static func build(difficultyOption:DifficutlyOption) ->Difficulty{
        switch difficultyOption {
        case .easy:
            return EasyDiffuculty()
        case .medium:
            return MediumDiffuculty()
        case .hard :
            return HardDiffuculty()
        }
    }
}

struct EasyDiffuculty:Difficulty {
    var numberOfPairs: Int = 4;
    var name = "Easy"
}

struct MediumDiffuculty:Difficulty {
    var numberOfPairs: Int = 6;
    var name = "Medium"
}
struct HardDiffuculty:Difficulty {
    var numberOfPairs: Int = 12;
    var name = "Hard"
}

