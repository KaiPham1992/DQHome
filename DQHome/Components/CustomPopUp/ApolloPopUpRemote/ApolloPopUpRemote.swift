//
//  ApolloPopUpRemote.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/30/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

// to controller
protocol ApolloPopUpRemoteDelegate: class {
    func didChangedValue(color: UIColor, brightness: CGFloat)
}

class ApolloPopUpRemote: BasePopUpView {
    
    lazy var aplloContent: ApolloPopUpRemoteContent = {
        let v = ApolloPopUpRemoteContent()
        v.delegate = self
        v.btnClose.addTarget(self, action: #selector(btnCloseTapped), for: .touchUpInside)
        return v
    }()
    
    weak var delegate: ApolloPopUpRemoteDelegate?
    
    override func setupView() {
        super.setupView()
        vContent.addSubview(aplloContent)
        aplloContent.fillSuperview()
    }
    func showPopUp(delegate: ApolloPopUpRemoteDelegate?) {
        self.delegate = delegate
        let rootFrame = UIScreen.main.bounds
        let newWidth = (886 / 1334) * rootFrame.width
        let newHeight = (577 / 750) * rootFrame.height
        
        super.showPopUp(width: newWidth, height: newHeight, type: BasePopUpViewType.zoomOut)
    }
    
    @objc func btnCloseTapped() {
        self.hidePopUp()
    }
    
    override func btnOverTapped() {
        print("Tap out side content")
    }
}

extension ApolloPopUpRemote: ApolloPopUpRemoteContentDelegate {
    func didChangeValue(color: UIColor, brightness: CGFloat) {
        delegate?.didChangedValue(color: color, brightness: brightness)
    }
    
}
