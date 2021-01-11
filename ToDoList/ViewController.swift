//
//  ViewController.swift
//  ToDoList
//
//  Created by Marcus Gardner on 10/01/2021.
//  Copyright © 2021 Marcus Gardner. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    //todo:
    //reset all checkmarks,
    // maybe add a filter,
    // set up coredata
    
    var list = ["get milk", "suck lips"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "To Do List"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let btnAdd = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(AddItem))
        let btnReset = UIBarButtonItem(title: "Reset All", style: .plain, target: self, action: #selector(ResetCheckedItems))
        let btnDeleteAll = UIBarButtonItem(title: "Delete All", style: .plain, target: self, action: #selector(DeleteAllItems))
        
        navigationItem.rightBarButtonItem = btnAdd
        navigationItem.leftBarButtonItems = [btnDeleteAll]
    }
    
    @objc func DeleteAllItems() {
        let deleteAllAlrt = UIAlertController(title: "Clear List", message: "Sure you want to delete all list items?", preferredStyle: .alert)
        deleteAllAlrt.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
            self.list.removeAll()
            self.tableView.reloadData()
        }))
        deleteAllAlrt.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(deleteAllAlrt, animated: true, completion: nil)
        
    }
    
    @objc func ResetCheckedItems() {
        
        print("Clear all checkmarks")
    }
    
    @objc func AddItem() {
        print("Add Item")
        let addItemAlrt = UIAlertController(title: "Add Item", message: "What would you like to add to the list?", preferredStyle: .alert)
        
        
        addItemAlrt.addTextField { (txtField) in
            txtField.placeholder = "E.g.. Grab milk"
            txtField.keyboardType = .default
            addItemAlrt.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
                print("Add item: " + txtField.text!)
                self.list.insert(txtField.text!, at: 0)
                self.tableView.performBatchUpdates({
                    self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .left)
                }, completion: nil)
            }))
        }
        
        
        addItemAlrt.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(addItemAlrt, animated: true, completion: nil)
    }
    
    //MARK: - TABLEBIEW CODE
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        if cell.accessoryType == .checkmark {
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .checkmark
        }
        
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            self.list.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .left)
            handler(true)
        }
        deleteAction.backgroundColor = .red
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = true
        return config
    }
    
    //MARK: - END OF TABLEVIEW CODE

}

