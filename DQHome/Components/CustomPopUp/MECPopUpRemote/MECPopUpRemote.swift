//
//  MECPopUpRemote.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/26/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import Foundation

class MECPopUpRemote: BasePopUpView {
    let mecPopUpRemoteContent: MECPopUpRemoteContent = {
       let v = MECPopUpRemoteContent()
        
        return v
    }()
    
    var resultCompletion: CompletionMessage?
    
    override func setupView() {
        super.setupView()
        vContent.addSubview(mecPopUpRemoteContent)
        mecPopUpRemoteContent.fillSuperview()
        
        mecPopUpRemoteContent.switchOne.delegate = self
        mecPopUpRemoteContent.switchTwo.delegate = self
        mecPopUpRemoteContent.switchThree.delegate = self
        mecPopUpRemoteContent.switchFour.delegate = self
        
        mecPopUpRemoteContent.btnClose.addTarget(self, action: #selector(btnClosedTapped), for: .touchUpInside)
    }
    
    func showPopUp(startStatus: String?, resultCompletion: CompletionMessage?) {
        self.resultCompletion = resultCompletion
        self.showPopUp(width: 300, height: 250, type: .zoomOut)
        mecPopUpRemoteContent.changeStatus(startStatus: startStatus)
        
    }
    
    @objc func btnClosedTapped() {
        self.hidePopUp()
    }
    
}

extension MECPopUpRemote: AppSwitchDelegate {
    func changedStatus() {
        let str = "\(mecPopUpRemoteContent.switchOne.isOn.toString()):\(mecPopUpRemoteContent.switchTwo.isOn.toString()):\(mecPopUpRemoteContent.switchThree.isOn.toString()):\(mecPopUpRemoteContent.switchFour.isOn.toString())"
        
        self.resultCompletion?(str)
    }
}
