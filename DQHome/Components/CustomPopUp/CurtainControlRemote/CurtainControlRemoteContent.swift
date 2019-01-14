//
//  CurtainControlRemoteContent.swift
//  DQHome
//
//  Created by Ngoc Duong on 11/21/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

enum CurtainControlRemoteContentAction {
    case open
    case close
    case openAll
    case closeAll
    case stop
}

protocol CurtainControlRemoteContentDelegate: class {
    func btnActionTapped(action: CurtainControlRemoteContentAction)
}

class CurtainControlRemoteContent: BaseViewXib {
    @IBOutlet weak var btnClose: UIButton!
    var action = CurtainControlRemoteContentAction.open
    weak var delegate: CurtainControlRemoteContentDelegate?
    
    @IBAction func btnActionTapped(sender: UIButton) {
        switch sender.tag {
        case 1:
            self.action = .open
        case 2:
            self.action = .close
        case 3:
            self.action = .openAll
        case 4:
            self.action = .closeAll
        case 5:
            self.action = .stop
        default:
            break 
        }
        
        delegate?.btnActionTapped(action: self.action)
    }
}
