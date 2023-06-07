//
//  Audio translation.swift
//  App3
//
//  Created by Никита Пеканов on 21.05.2023.
//

import Foundation



class GameAudioTranslation: GameAbstract {
    var indexOfSelectedCell: Int = 0
    
    override init(folders: [Folder]) {
        super.init(folders: folders)
    }
    
    func getTranslationsArray() -> [String]? {
        guard let cells = allCellsForGame, cells.count > 3 else {
            return nil
        }
        
        var arr: [String] = []
        
        if let firstTranslation = allCellsForGame?[indexOfSelectedCell].translation {
            arr.append(firstTranslation)
        }
        
        while arr.count <= 3 {
            if let randomTranslation = allCellsForGame?.randomElement()?.translation, !arr.contains(randomTranslation) {
                arr.append(randomTranslation)
            }
        }
        
        arr.shuffle()
        
        return arr
    }
    
    override func gameStep(enteredWord: String) -> Bool {
        if allCellsForGame?[indexOfSelectedCell].translation.lowercased() == enteredWord {
            scoreUp()
            indexOfSelectedCell += 1
            return true
        } else {
            indexOfSelectedCell += 1
            return false
        }
    }
}
