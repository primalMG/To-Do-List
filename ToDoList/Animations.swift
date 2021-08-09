//
//  Animations.swift
//  ToDoList
//
//  Created by Marcus Gardner on 09/08/2021.
//  Copyright © 2021 Marcus Gardner. All rights reserved.
//

import UIKit

typealias Animate = (UITableViewCell, IndexPath, UITableView) -> Void

enum AnimationShop {
    
    static func slideInAnimation(duration: TimeInterval) -> Animate {
        return { cell, IndexPath, tableView in
            cell.transform = CGAffineTransform(translationX: tableView.bounds.width, y: 0)
            
            UIView.animate(withDuration: duration, delay: 0.5, options: [.curveEaseInOut]) {
                cell.transform =  CGAffineTransform(translationX: 0, y: 0)
            }
        }
    }
}
