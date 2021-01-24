//
//  ViewController.swift
//  ToDoList
//
//  Created by Marcus Gardner on 10/01/2021.
//  Copyright © 2021 Marcus Gardner. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    //todo:
    //reset all checkmarks,
    // maybe add a filter/sort function
    //split alerts from main vc
    // set up coredata
    //Add a sub list functionality...
    
    var listItems: [NSManagedObject] = []
    

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRqst = NSFetchRequest<NSManagedObject>(entityName: "Items")
        
        do {
            listItems = try managedContext.fetch(fetchRqst)
        } catch let err as NSError {
            print(err)
        }
    }
    
    @objc func DeleteAllItems() {
        let deleteAllAlrt = UIAlertController(title: "Clear List", message: "Sure you want to delete all list items?", preferredStyle: .alert)
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Items")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        deleteAllAlrt.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
            self.listItems.removeAll()
            self.tableView.reloadData()
            do {
                try managedContext.execute(deleteRequest)
            } catch let err as NSError {
                print(err)
            }
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
        
        addItemAlrt.addTextField(configurationHandler: nil)
        addItemAlrt.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(addItemAlrt, animated: true, completion: nil)
    }
    
    func Save(item: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else { return }
        let date = NSDate()
        let managedContext = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Items", in: managedContext) else { return }
        
        let itm = NSManagedObject(entity: entity, insertInto: managedContext)
        
        itm.setValue(item, forKey: "item")
        itm.setValue(date, forKey: "date")
        
        do {
            print(date)
            try managedContext.save()
            listItems.insert(itm, at: 0)
            self.tableView.performBatchUpdates({
                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .left)
            }, completion: nil)
        } catch let error as NSError {
            print(error)
        }
    }
    
    
    //MARK: - TABLEBIEW CODE
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = listItems[indexPath.row]
        cell.textLabel?.text = item.value(forKeyPath: "item") as? String
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
            managedContext.delete(self.listItems[indexPath.row])
            do {
                try managedContext.save()
                self.listItems.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .left)
            } catch let err as NSError {
                print(err)
            }
            handler(true)
        }
        deleteAction.backgroundColor = .red
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = true
        return config
    }
    
    //MARK: - END OF TABLEVIEW CODE

}

