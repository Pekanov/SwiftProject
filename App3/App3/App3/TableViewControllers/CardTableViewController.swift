//
//  CardTableViewController.swift
//  App3
//
//  Created by Никита Пеканов on 18.04.2023.
//

import UIKit

class CardTableViewController: UITableViewController {
    
    var folderIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sortCell(_ sender: Any) {
        DataStorage.shared.cellSort(folderIndex: folderIndex)
        tableView.reloadData()
    }
    
    @IBAction func addNewCell(_ sender: Any) {
        let alertController = UIAlertController(title: "Add new word", message: nil, preferredStyle: .alert)

         alertController.addTextField { (wordField) in
             wordField.placeholder = "New word"
         }

         alertController.addTextField { (translationField) in
             translationField.placeholder = "Translation"
         }

         let addAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak alertController] _ in
             guard let alertController = alertController,
                   let newWord = alertController.textFields?[0].text?.trimmingCharacters(in: .whitespacesAndNewlines),
                   let translation = alertController.textFields?[1].text?.trimmingCharacters(in: .whitespacesAndNewlines),
                   !newWord.isEmpty, !translation.isEmpty,
                   let self = self else {
                       return
                   }
             
             let newCell = Cell(word: newWord, translation: translation)
             DataStorage.shared.folders[self.folderIndex].addCell(newCell: newCell)
             self.tableView.reloadData()
         }

         let cancelAction = UIAlertAction(title: "Cancel", style: .default)

         alertController.addAction(addAction)
         alertController.addAction(cancelAction)

         present(alertController, animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (DataStorage.shared.getFolder(at: folderIndex)?.cells.count) ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
        if let folder = DataStorage.shared.getFolder(at: folderIndex) {
            cell.textLabel?.text = folder.cells[indexPath.row].word
            cell.detailTextLabel?.text = folder.cells[indexPath.row].translation
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DataStorage.shared.folders[folderIndex].removeCell(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
      
}
