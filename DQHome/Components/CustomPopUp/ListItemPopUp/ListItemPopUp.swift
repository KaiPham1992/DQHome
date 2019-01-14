//
//  ListItemPopUp.swift
//  DQHome
//
//  Created by Ngoc Duong on 11/29/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

enum EditRoomType: String {
    case addDevice = "Thêm thiết bị"
    case changeBackground = "Đổi hình nền"
}

enum EditDeviceType: String {
    case tv = "tv"
    case conditioner = "aircon"
    case projector = "projector"
    case dimable = "dimable"
}

class ListItemPopUp: BasePopUpView {
    let listItemContent: ListItemContent = {
        let v = ListItemContent()
        
        return v
    }()
    
    var completion: CompletionAny?
    override func setupView() {
        super.setupView()
        vContent.addSubview(listItemContent)
        listItemContent.fillSuperview()
        
        //---
        listItemContent.btnClose.addTarget(self, action: #selector(btnCloseTapped), for: .touchUpInside)
        listItemContent.delegate = self
    }
    
    @objc func btnCloseTapped() {
        self.hidePopUp()
    }
    
    // frame: frame cua device will add to subroom
    func showPopUp(frame: CGRect, listItem: [Any], completion: @escaping CompletionAny){
        self.listItemContent.listItem = listItem
        self.completion = completion
        self.showPopUp()
    }
    
    func showPopUp(listItem: [Any], completion: @escaping CompletionAny){
        self.listItemContent.listItem = listItem
        self.completion = completion
        self.showPopUp()
    }
}

extension ListItemPopUp: ListItemContentDelegate {
    func selectedItemContent(item: Any) {
        self.hidePopUp()
        completion?(item)
    }
}
