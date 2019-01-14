//
//  LeftMenuCell.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/22/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

class LeftMenuCell: BaseTableCell {
    
    @IBOutlet weak var lbTitle: AppLabel!
    
    var itemMenu: Any? {
        didSet {
            guard let _item = itemMenu as? MenuType else { return }
            lbTitle.text = _item.rawValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setUpViews() {
        super.setUpViews()
//        addLineWhiteToBottom()
//        vLine.backgroundColor = UIColor.white.withAlphaComponent(0.7)
    }
}
