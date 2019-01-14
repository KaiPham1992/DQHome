//
//  AIRPopUpRemote.swift
//  DQHome
//
//  Created by Ngoc Duong on 11/14/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

class AIRPopUpRemote: BasePopUpView {
    let vRemoteTV: AIRPopUpRemoteContent = {
        let v = AIRPopUpRemoteContent()
        
        return v
    }()
    var completionAny: CompletionAny?
    
    override func setupView() {
        super.setupView()
        vContent.addSubview(vRemoteTV)
        vRemoteTV.fillSuperview()
        vRemoteTV.delegate = self
        
        //---
        vRemoteTV.btnClose.addTarget(self, action: #selector(btnCloseTapped), for: .touchUpInside)
    }
    
    @objc func btnCloseTapped() {
        self.hidePopUp()
    }
    
    func showPopUp(completion: CompletionAny?) {
        let height = UIScreen.main.bounds.height - 40
        showPopUp(width: height, height: height, type: .zoomOut)
        self.completionAny = completion
    }
    
}

extension AIRPopUpRemote: AIRPopUpRemoteContentDelegate {
    func btnActionTapped(action: AIRPopUpRemoteContentAction) {
        self.completionAny?(action)
    }
    
    
}
