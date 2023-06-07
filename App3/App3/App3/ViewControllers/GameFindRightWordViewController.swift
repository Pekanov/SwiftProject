//
//  GameFindRightWordViewController.swift
//  App3
//
//  Created by Никита Пеканов on 29.04.2023.
//

import UIKit

class GameFindRightWordViewController: UIViewController {
    
    var game: GameFindRightWord?
    
    var buttons: [UIButton] = []
    
    
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var button4: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttons = [button1, button2, button3]
        
        
        for button in buttons {
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
        
        formUpdate()

        // Do any additional setup after loading the view.
    }
    
    

  

    @objc func buttonTapped(_ sender: UIButton) {
            // обработка нажатия кнопки
            print("Button tapped")
        }
    
    
    
    
    
    
    func formUpdate(){
        guard let game = self.game, game.allCellsForGame!.count > 3 else{
            return
        }
        
        var translations = game.getTranslationsArray
        
        for (button, translation) in zip(buttons, translations){
            button.setTitle(translation, for: .normal)
        }
        
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
