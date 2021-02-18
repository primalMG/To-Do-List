//
//  Items.swift
//  ToDoList
//
//  Created by Marcus Gardner on 17/02/2021.
//  Copyright © 2021 Marcus Gardner. All rights reserved.
//

import Foundation

class Items: NSObject {
    var item : String
    var date : String
    var hasSubList: Bool
    
    init(item: String, date: String, hasSubList: Bool) {
        self.item = item
        self.date = date
        self.hasSubList = hasSubList
    }
}
