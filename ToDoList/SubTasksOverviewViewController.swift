//
//  SubTasksOverviewViewController.swift
//  ToDoList
//
//  Created by Marcus Gardner on 24/01/2021.
//  Copyright © 2021 Marcus Gardner. All rights reserved.
//

import UIKit

class SubTasksOverviewViewController: UITableViewController {
    
//    let subTasks: [

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Sub Tasks"
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Hello world"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: sub list of todo items.
    }
    


}
