import UIKit

class GameSettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var goToGameButton: UIButton!
    
    var selectedFolders: [Folder] = []
    var gameName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        goToGameButton.isEnabled = false
    }
    
    // Проверяет, выбраны ли папки для игры
    func isFoldersSelected() -> Bool {
        if !selectedFolders.isEmpty {
            var count = 0
            for folder in selectedFolders {
                count += folder.cells.count
            }
            if count > 4 {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    // Обработка нажатия кнопки перехода к игре
    @IBAction func goToGameButtonPressed(_ sender: UIButton) {
        switch gameName {
        case "FindRightWord":
            performSegue(withIdentifier: "GoToFindRightWordGame", sender: sender)
        case "EnterRightWord":
            performSegue(withIdentifier: "GoToEnterRightWordGame", sender: sender)
        case "AudioTranslation":
            performSegue(withIdentifier: "GoToAudioTranslationGame", sender: sender)
        default:
            break
        }
    }
    
    // Подготовка данных перед переходом к другому экрану
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "GoToFindRightWordGame":
            if let destinationVC = segue.destination as? GameFindRihtWordViewController {
                destinationVC.game = GameFindRightWord(folders: selectedFolders)
            }
        case "GoToEnterRightWordGame":
            if let destinationVC = segue.destination as? GameEnterRightWordViewController {
                destinationVC.game = GameEnterRightWord(folders: selectedFolders)
            }
        case "GoToAudioTranslationGame":
            if let destinationVC = segue.destination as? GameAudioTranslationViewController {
                destinationVC.game = GameAudioTranslation(folders: selectedFolders)
            }
        default:
            break
        }
    }
    
    // Включение/выключение кнопки в зависимости от выбранных папок
    func switchButtonsEnabled() {
        if isFoldersSelected() {
            goToGameButton.isEnabled = true
        } else {
            goToGameButton.isEnabled = false
        }
    }
    
    // MARK: - Table View DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Возвращаем количество доступных папок
        return DataStorage.shared.folders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FolderCellForGameSettings", for: indexPath)
        let folder = DataStorage.shared.folders[indexPath.row]

        // Настраиваем ячейку
        cell.textLabel?.text = folder.name

        // Проверяем, выбрана ли уже данная папка
        if selectedFolders.contains(folder) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }
    
    // MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Выбираем или отменяем выбор папки
        let folder = DataStorage.shared.folders[indexPath.row]
        if selectedFolders.contains(folder) {
            if let index = selectedFolders.firstIndex(of: folder) {
                selectedFolders.remove(at: index)
            }
        } else {
            selectedFolders.append(folder)
        }
        
        tableView.reloadData()
        switchButtonsEnabled()
    }
}
