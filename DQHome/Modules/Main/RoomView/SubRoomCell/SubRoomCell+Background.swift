//
//  SubRoomCell+Background.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 12/4/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

extension SubRoomCell: SelectPhotoCanCropPopUpDelegate {
    func showCropPicker() {
        guard let controller = UIApplication.topViewController() else { return }
        picker =  SelectPhotoCanCropPopUp(controller: controller, delegate: self)
        picker?.showCropPicker()
    }
    
    func didReceivePhoto(image: UIImage) {
        self.imgBackground.image = image
        
    }
}
