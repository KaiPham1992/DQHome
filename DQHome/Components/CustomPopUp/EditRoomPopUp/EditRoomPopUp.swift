//
//  EditRoomPopUp.swift
//  DQHome
//
//  Created by Ngoc Duong on 12/3/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

protocol EditRoomPopUpDelegate: class {
    func btnMoveTapped()
    func btnChangeSize()
    func btnDeleteTapped()
    func btnShowControlTapped()
}

class EditRoomPopUp: BasePopUpView {
    
    let vEditRoom: EditRoomPopUpContent = {
        let v = EditRoomPopUpContent()
        
        return v
    }()
    
    weak var delegate: EditRoomPopUpDelegate?
    
    override func setupView() {
        super.setupView()
        vContent.addSubview(vEditRoom)
        vEditRoom.fillSuperview()
        
        vEditRoom.btnClose.addTarget(self, action: #selector(btnCloseTapped), for: .touchUpInside)
        vEditRoom.btnSize.addTarget(self, action: #selector(btnSizeTapped), for: .touchUpInside)
        vEditRoom.btnMove.addTarget(self, action: #selector(btnMoveTapped), for: .touchUpInside)
        vEditRoom.btnDelete.addTarget(self, action: #selector(btnDeleteTapped), for: .touchUpInside)
        vEditRoom.btnShowControl.addTarget(self, action: #selector(btnShowControlTapped), for: .touchUpInside)
    }
    
    @objc func btnCloseTapped() {
        self.hidePopUp()
    }
    
    @objc func btnSizeTapped() {
        self.hidePopUp()
        delegate?.btnChangeSize()
    }
    
    @objc func btnMoveTapped() {
        self.hidePopUp()
        delegate?.btnMoveTapped()
    }
    
    @objc func btnDeleteTapped() {
        self.hidePopUp()
        delegate?.btnDeleteTapped()
    }
    
    @objc func btnShowControlTapped() {
        self.hidePopUp()
        delegate?.btnShowControlTapped()
    }
    
}
