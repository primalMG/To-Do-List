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
    // maybe add a filter/sort function
    //split alerts from main vc
    //Add a sub list functionality...
    
    var listItems = [Items]()
    var completedItems = [Items]()
    var subtask = false
    var ref : DatabaseReference!
    let rootRef = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootRef.child("Lists").observe(.childAdded) { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let item = dictionary["item"] as? String ?? ""
                let date = dictionary["date"] as? String ?? ""
                let hasSub = dictionary["hasSubList"] as? Bool ?? false
                let id = dictionary["id"] as? String ?? ""
                let completed = dictionary["completed"] as? Bool ?? false
                let items = Items(item: item, date: date, hasSubList: hasSub, id: id)

                if completed != false {
                    self.completedItems.append(items)
                } else {
                    self.listItems.append(items)
                }

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        title = "To Do List"
        
        tableView.register(OverviewTableViewCell.self, forCellReuseIdentifier: "cell")
        
        let btnAdd = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(AddItem))
        let btnDeleteAll = UIBarButtonItem(title: "Delete All", style: .plain, target: self, action: #selector(DeleteAllItems))
        
        navigationItem.rightBarButtonItem = btnAdd
        navigationItem.leftBarButtonItems = [btnDeleteAll]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        
        
    }
    
    @objc func DeleteAllItems() {
        let deleteAllAlrt = UIAlertController(title: "Clear List", message: "Sure you want to delete all list items?", preferredStyle: .alert)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        
        
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
        
        addItemAlrt.addTextField(configurationHandler: nil)
        addItemAlrt.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(addItemAlrt, animated: true, completion: nil)
    }
    
    
    func Save(item: String) {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd-MM-yy ss:mm:hh"
        let date = dateFormat.string(from: Date())
        let ref = rootRef.child("Lists").childByAutoId()
        let randID = ref.key
        let data = ["item": item, "date": date, "hasSubList": true, "completed" : false, "id" : randID!] as [String : Any]
        
        ref.setValue(data)
    }
    
    
    //MARK: - TABLEBIEW CODE
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OverviewTableViewCell
        let item = listItems[indexPath.row]
        cell.itemLabel.text = item.item
        cell.delegate = self
        
//        if item.hasSubList == true {
//            cell.accessoryType = .disclosureIndicator
//        } else {
//            cell.accessoryType = .none
//        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: false)

//        guard let cell = tableView.cellForRow(at: indexPath) else { return }

//        if cell.accessoryType == .checkmark {
//            cell.accessoryType = .none
//        } else {
//            cell.accessoryType = .checkmark
//        }

        let vc = ItemDetailViewController()
        self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
//        self.present(vc, animated: true, completion: nil)

    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            let row = self.listItems[indexPath.row].id
            self.rootRef.child("Lists").child(row).removeValue()
            self.listItems.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            handler(true)
        }
        deleteAction.backgroundColor = .red
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = true
        return config
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //MARK: - END OF TABLEVIEW CODE

}

extension ViewController: itemDelegate {
    func CompletedItem() {
        /* TODO: - Create bool link
            -remove item from array
            -add to other array
            -RELOADDDD the tableview
        */
        print("got here")
    }
    
    
}
