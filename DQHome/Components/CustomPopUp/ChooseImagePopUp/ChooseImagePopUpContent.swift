//
//  ChooseImagePopUpContent.swift
//  DQHome
//
//  Created by Ngoc Duong on 12/5/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

class ChooseImagePopUpContent: BaseViewXib {
    @IBOutlet weak var btnGalary: AppButtonPopUp!
    @IBOutlet weak var btnCamera: AppButtonPopUp!
    
    override func setUpViews() {
        super.setUpViews()
        btnGalary.setBorder(borderWidth: 1, borderColor: AppColor.white, cornerRadius: 15)
        btnCamera.setBorder(borderWidth: 1, borderColor: AppColor.white, cornerRadius: 15)
    }
}
