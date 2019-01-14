//
//  CurtainControlRemote.swift
//  DQHome
//
//  Created by Ngoc Duong on 11/21/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import Foundation
import UIKit

class CurtainControlRemote: BasePopUpView, CurtainControlRemoteContentDelegate {
    lazy var vRemoteMorto: CurtainControlRemoteContent = {
        let v = CurtainControlRemoteContent()
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
    
    func btnActionTapped(action: CurtainControlRemoteContentAction) {
        completionAny?(action)
    }
    
    @objc func btnCloseTapped() {
        self.hidePopUp()
    }
    
    func showPopUp(completion: CompletionAny?) {
        let width = UIScreen.main.bounds.width / 2
        showPopUp(width: width, height: width, type: .zoomOut)
        self.completionAny = completion
    }
    
}
