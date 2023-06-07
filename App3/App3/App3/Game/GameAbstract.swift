//
//  GameAbstract.swift
//  App3
//
//  Created by Никита Пеканов on 23.04.2023.
//

import Foundation

class GameAbstract {
    var allCellsForGame: [Cell]?
    var maxScore: Int?
    var score: Int
    
    init(folders: [Folder]) {
        self.score = 0
        allCellsForGame = getAllCells(folders: folders)
        maxScore = allCellsForGame?.count
        shuffle()
    }
    
    func getAllCells(folders: [Folder]) -> [Cell] {
        return folders.flatMap { $0.cells }
    }
    
    func shuffle() {
        allCellsForGame?.shuffle()
    }
    
    func getFirstCell() -> Cell? {
        return allCellsForGame?.first
    }
    
    func scoreUp() {
        score += 1
    }
    
    func gameStep(enteredWord: String) -> Bool {
        return true
    }
}
