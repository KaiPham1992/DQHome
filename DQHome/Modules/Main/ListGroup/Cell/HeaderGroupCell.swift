//
//  HeaderGroupCell.swift
//  DQHome
//
//  Created by Ngoc Duong on 11/22/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

class HeaderGroupCell: UICollectionViewCell {
    
    @IBOutlet weak var lbName: UILabel!
    
    var group: GroupEntity? {
        didSet {
            guard let _group = group else { return }
            lbName.text = "\(_group.name&)"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = AppColor.red
    }

}
