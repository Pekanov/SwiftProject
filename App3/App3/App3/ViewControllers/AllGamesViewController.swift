import UIKit

class AllGamesViewController: UIViewController {
    
    var gameName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Дополнительные настройки при загрузке представления
    }
    
    // Нажатие на кнопку "FindRightWord"
    @IBAction func findRightWordButton(_ sender: Any) {
        gameName = "FindRightWord"
        performSegue(withIdentifier: "GoToGameSettings", sender: sender)
    }
    
    // Нажатие на кнопку "EnterRightWord"
    @IBAction func enterRightWordButton(_ sender: Any) {
        gameName = "EnterRightWord"
        performSegue(withIdentifier: "GoToGameSettings", sender: sender)
    }
    
    // Нажатие на кнопку "AudioTranslation"
    @IBAction func audioTranslationButton(_ sender: Any) {
        gameName = "AudioTranslation"
        performSegue(withIdentifier: "GoToGameSettings", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToGameSettings",
           let destinationVC = segue.destination as? GameSettingsViewController,
           sender is UIButton {
            destinationVC.gameName = gameName
        }
    }
}
