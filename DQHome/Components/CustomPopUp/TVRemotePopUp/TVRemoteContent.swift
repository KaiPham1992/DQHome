//
//  TVRemoteContent.swift
//  DQHome
//
//  Created by Ngoc Duong on 12/16/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

protocol TVRemoteContentDelegate: class {
    func btnActionTapped(action: TVRemoteContentAction)
}


enum TVRemoteContentAction: String {
    // TV
    case chUpTV
    case chDownTV
    case volUpTV
    case volDownTV
    case okTV
    case onOffTV
    case mute
    
    // DVD
    case previousDVD
    case playDVD
    case pauseDVD
    case stopDVD
    case nextDVD
    case volUpDVD
    case volDownDVD
    case powerDVD
    case okDVD
    
    //---
    case number1
    case number2
    case number3
    case number4
    case number5
    case number6
    case number7
    case number8
    case number9
    case number0
}

class TVRemoteContent: BaseViewXib {
    @IBOutlet weak var btnClose: UIButton!
    var action: TVRemoteContentAction = TVRemoteContentAction.volUpTV
    
    weak var delegate: TVRemoteContentDelegate?
    
    override func setUpViews() {
        super.setUpViews()
    }
    
    @IBAction func btnActionTapped(sender: UIButton) {
        switch sender.tag {
            // TV
        case 2001:
            action = .chUpTV
        case 2002:
            action = .chDownTV
        case 2003:
            action = .volUpTV
        case 2004:
            action = .volDownTV
        case 2005:
            action = .okTV
        case 2006:
            action = .onOffTV
        case 2007:
            action = .mute
            
            //---
        case 10:
            action = .number0
        case 1:
            action = .number1
        case 2:
            action = .number2
        case 3:
            action = .number3
        case 4:
            action = .number4
        case 5:
            action = .number5
        case 6:
            action = .number6
        case 7:
            action = .number7
        case 8:
            action = .number8
        case 9:
            action = .number9
            
            // DVD
        case 1001:
            action = .previousDVD
        case 1002:
            action = .playDVD
        case 1003:
            action = .pauseDVD
        case 1004:
            action = .stopDVD
        case 1005:
            action = .nextDVD
        case 1006:
            action = .volDownDVD
        case 1007:
            action = .volUpDVD
        case 1008:
            action = .powerDVD
        case 1009:
            action = .okDVD
            
        default:
            action = .volUpTV
        }
        delegate?.btnActionTapped(action: action)
        
    }
}
