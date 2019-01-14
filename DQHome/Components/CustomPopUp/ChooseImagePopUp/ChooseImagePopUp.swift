//
//  ChooseImagePopUp.swift
//  DQHome
//
//  Created by Ngoc Duong on 12/5/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import Foundation

protocol ChooseImagePopUpDelegate: class {
    func btnCameraTapped()
    func btnGalaryTapped()
}

class ChooseImagePopUp: BasePopUpView {
    let chooseImagePopUpContent: ChooseImagePopUpContent = {
        let v = ChooseImagePopUpContent()
        
        return v
    }()
    
    weak var delegate: ChooseImagePopUpDelegate?
    
    override func setupView() {
        super.setupView()
        vContent.addSubview(chooseImagePopUpContent)
        chooseImagePopUpContent.fillSuperview()
        
        //---
        chooseImagePopUpContent.btnCamera.addTarget(self, action: #selector(btnCameraTapped), for: .touchUpInside)
        
        chooseImagePopUpContent.btnGalary.addTarget(self, action: #selector(btnGalaryTapped), for: .touchUpInside)
    }
    
    @objc func btnGalaryTapped() {
        self.hidePopUp()
        delegate?.btnGalaryTapped()
    }

    @objc func btnCameraTapped() {
        self.hidePopUp()
        delegate?.btnCameraTapped()
    }

}
