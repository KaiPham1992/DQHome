//
//  ListItemContent.swift
//  DQHome
//
//  Created by Ngoc Duong on 11/29/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

protocol ListItemContentDelegate: class {
    func selectedItemContent(item: Any)
}

class ListItemContent: BaseViewXib {
    @IBOutlet weak  var tbItem: UITableView!
     @IBOutlet weak var btnClose: UIButton!
    
    
    var listItem = [Any]() {
        didSet {
            tbItem.reloadData()
        }
    }
    
    weak var delegate: ListItemContentDelegate?
    
    override func setUpViews() {
        super.setUpViews()
        configureTable()
    }
}


extension ListItemContent: UITableViewDelegate, UITableViewDataSource {
    func configureTable() {
        tbItem.delegate = self
        tbItem.dataSource  = self
        tbItem.registerXibFile(ListItemContentCell.self)
        tbItem.backgroundColor  = .clear
        tbItem.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbItem.dequeue(ListItemContentCell.self, for: indexPath)
        cell.itemMenu = self.listItem[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.listItem[indexPath.item]
        delegate?.selectedItemContent(item: item)
    }
}
