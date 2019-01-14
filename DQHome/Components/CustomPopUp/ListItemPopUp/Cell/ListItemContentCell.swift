//
//  ListItemContentCell.swift
//  DQHome
//
//  Created by Ngoc Duong on 11/29/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

class ListItemContentCell: BaseTableCell {
    @IBOutlet weak var lbTitle: AppLabel!
    var itemMenu: Any? {
        didSet {
            if let item = itemMenu as? DeviceData {
                lbTitle.text = item.name
            }
            
            if let item = itemMenu as? EditRoomType {
                lbTitle.text = item.rawValue
            }
            
            if let item = itemMenu as? EditDeviceType {
                let str = item.rawValue
                lbTitle.text = str.capitalizingFirstLetter()
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
