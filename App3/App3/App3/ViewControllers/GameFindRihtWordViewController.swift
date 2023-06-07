//
//  GameFindRihtWordViewController.swift
//  App3
//
//  Created by Никита Пеканов on 29.04.2023.
//

import UIKit
import AVFoundation

class GameFindRihtWordViewController: UIViewController {
    
    var game: GameFindRightWord?
    var buttons: [UIButton] = []
    
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    
    @IBOutlet weak var Score: UILabel!
    @IBOutlet weak var Word: UILabel!
    @IBOutlet weak var CheckOut: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttons = [button1, button2, button3, button4]
        
        
        for button in buttons {
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
        
        formUpdate()
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        // Обработка нажатия кнопки
        for button in buttons {
            button.isEnabled = false
        }
        
        if let title = sender.title(for: .normal)?.lowercased(), let game = self.game {
            if game.gameStep(enteredWord: title) {
                CheckOut.text = "Good"
                CheckOut.textColor = UIColor.systemGreen
            } else {
                CheckOut.text = "Bad"
                CheckOut.textColor = UIColor.red
            }
            
            Score.text = String(game.score)
            CheckOut.isHidden = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                if let cells = game.allCellsForGame, game.indexOfSelectedCell <= cells.count - 1 {
                    self.formUpdate()
                    for button in self.buttons {
                        button.isEnabled = true
                    }
                } else {
                    self.performSegue(withIdentifier: "GoToResults2", sender: self)
                }
            }
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToResults2", let destinationVC = segue.destination as? ScoreViewController{
            destinationVC.game = self.game
        }
    }
    
    
    
    func formUpdate(){
        guard let game = self.game, game.allCellsForGame!.count > 4 else{
            return
        }
        if let translations = game.getTranslationsArray(){
            for (button, translation) in zip(buttons, translations){
                button.setTitle(translation, for: .normal)
            }
        }
        
        Score.text = String(game.score)
        Word.text = game.allCellsForGame?[game.indexOfSelectedCell].word
        CheckOut.isHidden = true
        
        
        
    }
    
}
