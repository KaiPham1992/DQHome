//
//  RightMenuCell.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/22/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

class RightMenuCell: BaseTableCell {

    @IBOutlet weak var lbTitle: AppLabel!
    
    var itemMenu: Any? {
        didSet {
            guard let _item = itemMenu as? String else { return }
            lbTitle.text = _item
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
}
