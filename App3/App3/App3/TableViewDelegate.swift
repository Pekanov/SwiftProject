//
//  TableViewDelegate.swift
//  App3
//
//  Created by Никита Пеканов on 19.04.2023.
//

import Foundation
import UIKit



protocol TableViewDelegate: AnyObject {
    func tableView(_ tableView: UITableView, didSelectCellAt index: Int)
}
