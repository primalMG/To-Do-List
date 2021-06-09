//
//  ItemDetailViewController.swift
//  ToDoList
//
//  Created by Marcus Gardner on 18/02/2021.
//  Copyright © 2021 Marcus Gardner. All rights reserved.
//

import UIKit

class ItemDetailViewController: UITableViewController {
    
    var id: Items? {
        didSet {
            if let id = self.id {
                title = id.item
                print(id)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Item Details"
        
        view.backgroundColor = .white
        
        tableView.register(SubTaskTableViewCell.self, forCellReuseIdentifier: "cell")

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SubTaskTableViewCell
        cell.itemLabel.text = "Sub detail goes here"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
//            let row = self
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            handler(true)
        }
        deleteAction.backgroundColor = .red
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = true
        return config
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
