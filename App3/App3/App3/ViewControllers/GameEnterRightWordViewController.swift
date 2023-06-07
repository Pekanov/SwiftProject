//
//  GameEnterRightWordViewController.swift
//  App3
//
//  Created by Никита Пеканов on 23.04.2023.
//

import UIKit

class GameEnterRightWordViewController: UIViewController {
    
    var game: GameEnterRightWord?
    
    @IBOutlet weak var Score: UILabel!
    
    @IBOutlet weak var Word: UILabel!
    
    @IBOutlet weak var CheckOut: UILabel!
    
    @IBOutlet weak var TextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        if let game = game {
            Score.text = String(game.score)
            Word.text = game.getFirstCell()?.word
            CheckOut.isHidden = true
        }
    }
    
    
    @IBAction func CheckTranslation(_ sender: Any) {
        if let enteredTranslation = TextField.text?.lowercased(), !enteredTranslation.isEmpty, let game = self.game {
            if game.gameStep(enteredWord: enteredTranslation) {
                CheckOut.text = "Good"
                CheckOut.textColor = UIColor.systemGreen
            } else {
                CheckOut.text = "Bad"
                CheckOut.textColor = UIColor.red
            }
            
            Score.text = String(game.score)
            TextField.text = ""
            CheckOut.isHidden = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.CheckOut.isHidden = true
                if let cells = game.allCellsForGame, !cells.isEmpty {
                    self.Word.text = game.getFirstCell()?.word
                } else {
                    self.performSegue(withIdentifier: "GoToResults1", sender: self)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToResults1", let destinationVC = segue.destination as? ScoreViewController{
            destinationVC.game = self.game
        }
    }


}
