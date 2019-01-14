//
//  CurtainControlRemoteContent.swift
//  DQHome
//
//  Created by Ngoc Duong on 11/21/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

enum CurtainControlPopUpContentAction: Int {
    case open = 1
    case close = 2
    case stop = 0
}

protocol CurtainControlPopUpContentDelegate: class {
    func btnActionTapped(action: CurtainControlPopUpContentAction)
}

class CurtainControlPopUpContent: BaseViewXib {
    @IBOutlet weak var btnClose: UIButton!
    var action = CurtainControlPopUpContentAction.open
    weak var delegate: CurtainControlPopUpContentDelegate?
    
    @IBAction func btnActionTapped(sender: UIButton) {
        switch sender.tag {
        case 1:
            self.action = .open
        case 2:
            self.action = .close
        case 3:
            self.action = .stop
        default:
           self.action = .stop
        }
        
        delegate?.btnActionTapped(action: self.action)
    }
}
