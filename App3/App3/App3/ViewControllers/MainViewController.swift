import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var folderTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    // Настройка таблицы
    func setupTableView() {
        folderTableView.delegate = self
        folderTableView.dataSource = self
    }
    
    // Сортировка папок
    @IBAction func sortFolders(_ sender: Any) {
        DataStorage.shared.folderSort()
        folderTableView.reloadData()
    }
    
    // Добавление новой папки
    @IBAction func addNewFolder(_ sender: Any) {
        let alertController = UIAlertController(title: "Add new folder", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "New folder"
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] (_) in
            guard let textField = alertController.textFields?.first,
                  let newFolderName = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                  !newFolderName.isEmpty else {
                return
            }
            
            let newFolder = Folder(name: newFolderName, cells: [])
            DataStorage.shared.addFolder(newFolder)
            self?.folderTableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Table View DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataStorage.shared.folders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Folder", for: indexPath)
        cell.textLabel?.text = DataStorage.shared.getFolder(at: indexPath.row)?.name
        return cell
    }
    
    // MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showCards", sender: indexPath.row)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCards",
           let selectedRowIndex = sender as? Int,
           let destinationVC = segue.destination as? CardTableViewController {
            destinationVC.folderIndex = selectedRowIndex
        }
    }
    
    // MARK: - Editing
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DataStorage.shared.removeFolder(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
