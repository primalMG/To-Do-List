//
//  ItemDetailViewController.swift
//  ToDoList
//
//  Created by Marcus Gardner on 18/02/2021.
//  Copyright © 2021 Marcus Gardner. All rights reserved.
//

import UIKit

class ItemDetailViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Item Details"
        
        view.backgroundColor = .systemYellow
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Hello Detail"
        return cell
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
