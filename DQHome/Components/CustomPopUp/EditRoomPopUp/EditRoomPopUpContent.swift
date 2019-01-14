//
//  EditRoomPopUpContent.swift
//  DQHome
//
//  Created by Ngoc Duong on 12/3/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

class EditRoomPopUpContent: BaseViewXib {
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnSize: AppButtonPopUp!
    @IBOutlet weak var btnMove: AppButtonPopUp!
    @IBOutlet weak var btnDelete: AppButtonPopUp!
    @IBOutlet weak var btnShowControl: AppButtonPopUp!
    
    override func setUpViews() {
        super.setUpViews()
        btnSize.setBorder(borderWidth: 1, borderColor: AppColor.white, cornerRadius: btnSize.frame.height / 2 )
        btnMove.setBorder(borderWidth: 1, borderColor: AppColor.white, cornerRadius: btnSize.frame.height / 2 )
        btnDelete.setBorder(borderWidth: 1, borderColor: AppColor.white, cornerRadius: btnSize.frame.height / 2 )
         btnShowControl.setBorder(borderWidth: 1, borderColor: AppColor.white, cornerRadius: btnSize.frame.height / 2 )
    }
    
}
