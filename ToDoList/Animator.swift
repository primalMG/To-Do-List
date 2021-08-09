//
//  Animator.swift
//  ToDoList
//
//  Created by Marcus Gardner on 09/08/2021.
//  Copyright © 2021 Marcus Gardner. All rights reserved.
//

import UIKit

final class Animations {
    private var hasAnimatedCell = false
    private let animation: Animate
    
    init(animation: @escaping Animate) {
        self.animation = animation
    }
    
    func Animate(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
        guard !hasAnimatedCell else { return }
        
        animation(cell, indexPath, tableView)
        
        hasAnimatedCell = tableView.LastVisibleCell(at: indexPath)
    }
}

extension UITableView {
    
    func LastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else { return false }
    
        return lastIndexPath == indexPath

    }
    
    
}
