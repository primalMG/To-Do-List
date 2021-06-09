//
//  SubTasks.swift
//  ToDoList
//
//  Created by Marcus Gardner on 24/01/2021.
//  Copyright © 2021 Marcus Gardner. All rights reserved.
//

import Foundation

class subItems: NSObject {
    var item : String
    var date : String
    var id : String
    
    init(item: String, date: String, id: String) {
        self.item = item
        self.date = date
        self.id = id
    }
}
