//
//  ViewController.swift
//  ToDoList
//
//  Created by Marcus Gardner on 10/01/2021.
//  Copyright © 2021 Marcus Gardner. All rights reserved.
//

import UIKit
import FirebaseDatabase


class ViewController: UITableViewController {
    
    //todo:
    //reset all checkmarks,
    // maybe add a filter/sort function
    //split alerts from main vc
    // set up coredata
    //Add a sub list functionality...
    
//    var listItems: [List] = []
    var subtask = false
    var ref : DatabaseReference!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        ref = Database.database().reference()
        
        title = "To Do List"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let btnAdd = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(AddItem))
//        let btnReset = UIBarButtonItem(title: "Reset All", style: .plain, target: self, action: #selector(ResetCheckedItems))
        let btnDeleteAll = UIBarButtonItem(title: "Delete All", style: .plain, target: self, action: #selector(DeleteAllItems))
        
        navigationItem.rightBarButtonItem = btnAdd
        navigationItem.leftBarButtonItems = [btnDeleteAll]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
    }
    
    @objc func DeleteAllItems() {
        let deleteAllAlrt = UIAlertController(title: "Clear List", message: "Sure you want to delete all list items?", preferredStyle: .alert)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        deleteAllAlrt.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
//            self.listItems.removeAll()
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
        
        
        addItemAlrt.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            guard let textField = addItemAlrt.textFields?.first, let savedItem = textField.text else { return }
            self.Save(item: savedItem)
        }))
        
        addItemAlrt.addAction(UIAlertAction(title: "Add Sub List", style: .default, handler: { (action) in
            guard let textField = addItemAlrt.textFields?.first, let savedItem = textField.text else { return }
            self.SaveSubTasks()
        }))
        
        addItemAlrt.addTextField(configurationHandler: nil)
        addItemAlrt.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(addItemAlrt, animated: true, completion: nil)
    }
    
    func SaveSubTasks() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else { return }
        let date = NSDate()
        let managedContext = appDelegate.persistentContainer.viewContext
        
//        guard let entity = NSEntityDescription.entity(forEntityName: "", in: <#T##NSManagedObjectContext#>)
    }
    
    func Save(item: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else { return }
        let date = NSDate()
        let managedContext = appDelegate.persistentContainer.viewContext
        
//        if booleanState == true {
//            itm.setValue(subtask = true, forKey: "subTasks")
//        }
        
        
    }
    
    
    //MARK: - TABLEBIEW CODE
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let item = listItems[indexPath.row]
//        cell.textLabel?.text = item.value(forKeyPath: "item") as? String
//        if item.value(forKey: "subtask") as? Bool == true {
//            cell.accessoryType = .disclosureIndicator
//        } else {
//            cell.accessoryType = .none
//        }
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
             guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
//            managedContext.delete(self.listItems[indexPath.row])
            handler(true)
        }
        deleteAction.backgroundColor = .red
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = true
        return config
    }
    
    //MARK: - END OF TABLEVIEW CODE

}

