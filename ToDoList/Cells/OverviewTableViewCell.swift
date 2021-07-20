//
//  OverviewTableViewCell.swift
//  ToDoList
//
//  Created by Marcus Gardner on 21/02/2021.
//  Copyright © 2021 Marcus Gardner. All rights reserved.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layoutIfNeeded()
        // Initialization code
    }
    
    var localIndexPath: IndexPath!
    
    let itemLabel : UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20)
        return lbl
    }()
    
    let btnChecked : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.layer.cornerRadius = btn.frame.size.height / 2
        btn.clipsToBounds = true
        btn.layer.borderWidth = 1
        btn.layer.masksToBounds = true
        btn.layer.borderColor = UIColor.purple.cgColor
        
        print(btn.layer.cornerRadius)
        return btn
    }()
    
    let btninfo : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        
        btn.layer.borderColor = UIColor.blue.cgColor
        return btn
    }()
    
    let txtItem : UITextField = {
        let txt = UITextField()
        
        txt.placeholder = "Enter the ting here"
        
        return txt
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        btnChecked.translatesAutoresizingMaskIntoConstraints = false
        btninfo.translatesAutoresizingMaskIntoConstraints = false
        txtItem.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(itemLabel)
        self.contentView.addSubview(btnChecked)
        self.contentView.addSubview(btninfo)
        self.contentView.addSubview(txtItem)
        
        
        NSLayoutConstraint.activate([
            itemLabel.leadingAnchor.constraint(equalTo: self.btnChecked.trailingAnchor, constant: 10),
            itemLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 13),
            
            btnChecked.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 40),
//            btnChecked.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 15),
//            btnChecked.heightAnchor.constraint(equalToConstant: 20),
            
            
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
