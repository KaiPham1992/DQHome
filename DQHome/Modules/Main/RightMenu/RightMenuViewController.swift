//
//  RightMenuViewController.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/22/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

class RightMenuViewController: BaseViewController, RightMenuViewProtocol {
    func didCreatedItemMenu(listItem: [Any]) {
        self.listItem = listItem
    }
    
    var presenter: RightMenuPresenterProtocol?
    @IBOutlet weak var tbMenu: UITableView!
    var listItem = [Any]() {
        didSet {
            tbMenu.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppColor.backgroundMenu
        configureTable()
        presenter?.viewDidLoad()
    }
}

extension RightMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTable() {
        tbMenu.delegate = self
        tbMenu.dataSource  = self
        tbMenu.registerXibFile(HeaderRightCell.self)
        tbMenu.registerXibFile(RightMenuCell.self)
        tbMenu.backgroundColor  = .clear
        tbMenu.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == 0 {
            let cell = tbMenu.dequeue(HeaderRightCell.self, for: indexPath)
            cell.itemMenu = listItem[indexPath.item]
            return cell
        } else {
            let cell = tbMenu.dequeue(RightMenuCell.self, for: indexPath)
            cell.itemMenu = listItem[indexPath.item]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.item == 0 ? 50: 35
    }
}
