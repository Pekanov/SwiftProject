//
//  DataStorage.swift
//  App3
//
//  Created by Никита Пеканов on 18.04.2023.
//

import Foundation


// Структура ячейки, хранящей слово и его перевод
struct Cell: Codable {
    var word: String
    var translation: String
}

// Структура папки, содержащей массив ячеек и методы для работы с ними
struct Folder: Codable, Equatable{
    
    var name : String
    var cells: [Cell]
    
    mutating func addCell(newCell: Cell) {
        cells.append(newCell)
        
    }
    
    mutating func removeCell(at index: Int) {
        cells.remove(at: index)
    }
    
    static func ==(lhs: Folder, rhs: Folder) -> Bool {
            return lhs.name == rhs.name
        }
}

// Структура, содержащая массив папок и методы для работы с ними
struct DataStorage: Codable{
    
    static var shared = DataStorage()
    
    var folders: [Folder] = []
    
    mutating func folderSort() {
            folders.sort {$0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending}
    }
    
    
    mutating func cellSort(folderIndex: Int) {
        folders[folderIndex].cells.sort{$0.word.localizedCaseInsensitiveCompare($1.word) == .orderedAscending}
    }
        
    mutating func addFolder(_ folder: Folder) {
        folders.append(folder)
        print("addFolder",folders.count)
        saveData()
    }
    
    mutating func removeFolder(at index: Int) {
        folders.remove(at: index)
        saveData()
    }
    
    mutating func getFolder(at index: Int) -> Folder? {
        guard folders.indices.contains(index) else {
            return nil
        }
        return folders[index]
    }
    
    mutating func updateFolder(at index: Int, with newFolder: Folder) {
        folders[index] = newFolder
        saveData()
    }
    
    
    // Сохранение данных в файл
    func saveData() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(self.folders)
            try data.write(to: dataFilePath(), options: .atomic)
        } catch {
            print("Failed to save data: \(error.localizedDescription)")
        }
    }
    
    // Загрузка данных из файла
    mutating func loadData() {
        let decoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: dataFilePath())
            self.folders = try decoder.decode([Folder].self, from: data)
        } catch {
            print("Failed to load data: \(error.localizedDescription)")
        }
    }
    
    
    // Путь к файлу с данными
    private func dataFilePath() -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsURL.appendingPathComponent("data.json")
    }
    
    func createDataFile() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent("data.json")
        
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                let data = try JSONEncoder().encode(DataStorage.shared)
                try data.write(to: fileURL, options: .atomic)
            } catch {
                print("Error creating file: \(error.localizedDescription)")
            }
        }
    }
    
}
