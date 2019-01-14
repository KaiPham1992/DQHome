//
//  HomeCell.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/22/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

class GroupCell: UICollectionViewCell {
    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var lbName: AppLabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var imgBackground: UIImageView!
    
    var item: Any? {
        didSet {
            guard let room = item as? GroupEntity else { return }
            lbName.text = room.name
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.vBackground.backgroundColor = AppColor.backgroundItem
    }

}
