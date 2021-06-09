//
//  SubTaskTableViewCell.swift
//  ToDoList
//
//  Created by Marcus Gardner on 07/06/2021.
//  Copyright © 2021 Marcus Gardner. All rights reserved.
//

import UIKit

class SubTaskTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    let itemLabel : UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20)
        return lbl
    }()
    
    let btnChecked : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.darkGray.cgColor
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        btnChecked.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(itemLabel)
        self.contentView.addSubview(btnChecked)
        
        NSLayoutConstraint.activate([
            itemLabel.leadingAnchor.constraint(equalTo: self.btnChecked.trailingAnchor, constant: 10),
            itemLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            btnChecked.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            btnChecked.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            btnChecked.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
