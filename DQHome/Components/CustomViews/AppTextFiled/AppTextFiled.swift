//
//  AppTextFiled.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/18/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

class AppTextField : UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
    }
    
    private func setUpViews() {
        self.backgroundColor = .clear
        //add line
        let vLine = UIView()
        vLine.backgroundColor = AppColor.white
        addSubview(vLine)
        vLine.anchor(left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, leftConstant: 0, bottomConstant: 0, rightConstant: 0, heightConstant: 1)
        self.borderStyle = .none
        
        // font style
        self.textColor = AppColor.white
        self.placeHolderColor = AppColor.white.withAlphaComponent(0.5)
        self.font = AppFont.fontRegular17
    }
    
    func setPlaceHolder(placeholder: String) {
        self.attributedPlaceholder = placeholder.showLanguage.toAttributedString(color: AppColor.placeHolderWhite, font: self.font, isUnderLine: false)
    }
}
