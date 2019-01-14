//
//  CurtainControlRemote.swift
//  DQHome
//
//  Created by Ngoc Duong on 11/21/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import Foundation
import UIKit

class CurtainControlPopUp: BasePopUpView, CurtainControlPopUpContentDelegate {
    
    lazy var vRemoteMorto: CurtainControlPopUpContent = {
        let v = CurtainControlPopUpContent()
        v.delegate = self
        return v
    }()
    
    var completionAny: CompletionAny?
    
    override func setupView() {
        super.setupView()
        vContent.addSubview(vRemoteMorto)
        vRemoteMorto.fillSuperview()
        
        //---
        vRemoteMorto.btnClose.addTarget(self, action: #selector(btnCloseTapped), for: .touchUpInside)
    }
    
    @objc func btnCloseTapped() {
        self.hidePopUp()
    }
    
    func btnActionTapped(action: CurtainControlPopUpContentAction) {
        self.hidePopUp()
        completionAny?(action)
    }
    
    func showPopUp(completion: CompletionAny?) {
        let width = UIScreen.main.bounds.width / 2
        showPopUp(width: width, height: width, type: .zoomOut)
        self.completionAny = completion
    }
    
}
