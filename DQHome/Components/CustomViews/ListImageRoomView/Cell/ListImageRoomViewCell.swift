//
//  ListImageRoomViewCell.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/30/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

class ListImageRoomViewCell: BaseCollectionCell {
    let imgIcon: UIImageView = {
        let img = UIImageView()
        img.setBorder(borderWidth: 1, borderColor: AppColor.gray, cornerRadius: 0)
        return img
    }()
    
    var roomData: RoomData? {
        didSet {
            guard let _roomData = roomData else { return }
            self.imgIcon.image =  _roomData.getBackground()
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imgIcon)
        imgIcon.fillSuperview()
    }
}
