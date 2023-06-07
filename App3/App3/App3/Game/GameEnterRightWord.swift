//
//  GameEnterRightWord.swift
//  App3
//
//  Created by Никита Пеканов on 23.04.2023.
//

import Foundation


class GameEnterRightWord: GameAbstract {
    override init(folders: [Folder]) {
        super.init(folders: folders)
    }
    
    override func gameStep(enteredWord: String) -> Bool {
        if getFirstCell()?.translation.lowercased() == enteredWord {
            scoreUp()
            allCellsForGame?.removeFirst()
            return true
        } else {
            allCellsForGame?.removeFirst()
            return false
        }
    }
}

