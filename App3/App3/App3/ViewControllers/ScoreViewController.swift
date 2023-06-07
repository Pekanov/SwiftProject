//
//  ScoreViewController.swift
//  App3
//
//  Created by Никита Пеканов on 25.04.2023.
//

import UIKit

class ScoreViewController: UIViewController {
    
    var game: GameAbstract?
    
    @IBOutlet weak var yourScore: UILabel!
    @IBOutlet weak var maxScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationItem.hidesBackButton = true
        if let game = self.game, let maxScore = game.maxScore{
            self.maxScore.text = String(maxScore)
            self.yourScore.text = String(game.score)
        }
    }
    
    @IBAction func GoToAllGames(_ sender: Any) {
        if let navigationController = self.navigationController,
            let viewController = navigationController.viewControllers.first(where: { $0 is AllGamesViewController }) {
                navigationController.popToViewController(viewController, animated: true)
            }
        }

}
