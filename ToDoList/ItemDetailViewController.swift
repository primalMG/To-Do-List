//
//  ItemDetailViewController.swift
//  ToDoList
//
//  Created by Marcus Gardner on 18/02/2021.
//  Copyright © 2021 Marcus Gardner. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ItemDetailViewController: UITableViewController {
    
    var taskId: Items? {
        didSet {
            if let id = self.taskId {
                title = id.item
            }
        }
    }
    
    var ref : DatabaseReference!
    let rootRef = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - Navigation Buttons
        let btnAdd = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(AddSubItem))
        let btnCancel = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(CancelButton))
        
        navigationItem.rightBarButtonItem = btnAdd
        navigationItem.leftBarButtonItem = btnCancel
        
        tableView.register(SubTaskTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    @objc func AddSubItem() {
        let addSubItemAlrt = UIAlertController(title: "Add Task", message: "Add a sub task to " + taskId!.item + " list", preferredStyle: .alert)
        
        addSubItemAlrt.addAction(UIAlertAction(title: "Add", style: .default, handler: { action in
            guard let textField = addSubItemAlrt.textFields?.first, let savedItem = textField.text else { return }
            self.Save(item: savedItem)
        }))
        
        addSubItemAlrt.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        addSubItemAlrt.addTextField { txtField in
            txtField.placeholder = "Enter your sub item"
        }
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd-MM-yy ss:mm:hh"
        let date = dateFormat.string(from: Date())
        let ref = rootRef.child("SubTasks").childByAutoId()
        let taskId = ref.key
        let data = ["item": "sub item", "date": date, "completed" : false,"taskId": taskId!, "id": taskId!] as [String : Any]
        
        ref.setValue(data)
    }
    
    @objc func CancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func Save(item: String) {
        
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
