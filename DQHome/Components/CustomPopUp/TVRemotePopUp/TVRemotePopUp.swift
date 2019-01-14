//
//  TVRemotePopUp.swift
//  DQHome
//
//  Created by Ngoc Duong on 12/16/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import Foundation

class TVRemotePopUp: BasePopUpView, TVRemoteContentDelegate {
    let vTVRemoteContent: TVRemoteContent = {
        let v = TVRemoteContent()
        
        return v
    }()
    
    var completionAny: CompletionAny?
    
    override func setupView() {
        super.setupView()
        vContent.addSubview(vTVRemoteContent)
        vTVRemoteContent.fillSuperview()
        vTVRemoteContent.delegate = self
        vTVRemoteContent.btnClose.addTarget(self, action: #selector(btnCloseTapped), for: .touchUpInside)
    }
    
    @objc func btnCloseTapped() {
        self.hidePopUp()
    }
    
    func btnActionTapped(action: TVRemoteContentAction) {
        completionAny?(action)
    }
    
    func showPopUp(completion: CompletionAny?) {
        showPopUp(width: 500, height: 250, type: .zoomOut)
        self.completionAny = completion
    }
}


