//
//  HomeCell.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/22/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

class SceneCell: UICollectionViewCell {
    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var lbName: AppLabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var imgIconScene: UIImageView!
    
    var item: Any? {
        didSet {
            guard let scene = item as? SceneEntity else { return }
            lbName.text = scene.name
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.vBackground.backgroundColor = AppColor.backgroundItem
    }

}
