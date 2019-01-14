//
//  HomeCell.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/22/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var lbName: AppLabel!
    @IBOutlet weak var imgGroup: UIImageView!
    
    var item: Any? {
        didSet {
            guard let group = item as? GroupEntity else { return }
            lbName.text = group.name
            if group.listRoomData.count > 0 {
                imgGroup.image = group.listRoomData[0].getBackground()
            }
            
            self.setBorder(borderWidth: 1, borderColor: AppColor.line, cornerRadius: 0)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.vBackground.backgroundColor = AppColor.backgroundItem
        lbName.setFont(size: 17, font: AppFont.fontBold17)
    }

}
