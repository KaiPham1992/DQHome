//
//  AIRPopUpRemoteContent.swift
//  DQHome
//
//  Created by Ngoc Duong on 11/14/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

protocol AIRPopUpRemoteContentDelegate: class {
    func btnActionTapped(action: AIRPopUpRemoteContentAction)
}

enum AIRPopUpRemoteContentAction {
    case on
    case off
    case auto
    case down
    case up
    case cool
    case dry
    case wind
    case apply
}

class AIRPopUpRemoteContent: BaseViewXib {
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var vTemperature: UIView!
    @IBOutlet weak var btnDown: UIButton!
    @IBOutlet weak var btnUp: UIButton!
    @IBOutlet weak var lbTemperature: UILabel!
    
    var action: AIRPopUpRemoteContentAction = AIRPopUpRemoteContentAction.on
    weak var delegate: AIRPopUpRemoteContentDelegate?
    
    var temperature: Int  = 20
    
    override func setUpViews() {
        super.setUpViews()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.vTemperature.setBorder(borderWidth: 3, borderColor: .white, cornerRadius: self.vTemperature.frame.height/2)
            
            self.setTemperature(temperature: self.temperature)
            
        }
        
    }
    
    func setTemperature(temperature: Int) {
        let attr1 = temperature.description.toAttributedString(color: AppColor.white, font: AppFont.fontBold40, isUnderLine: false)
        let attr2 = "O".description.toAttributedString(color: AppColor.white, font: AppFont.fontRegular13, isUnderLine: false)
        let attr3 = "C".description.toAttributedString(color: AppColor.white, font: AppFont.fontRegular17, isUnderLine: false)
        let attr = NSMutableAttributedString()
        attr.append(attr1)
        attr.append(attr2)
        attr.append(attr3)
        lbTemperature.attributedText = attr
    }
    
    
    @IBAction func btnActionTapped(sender: UIButton) {
        switch sender.tag {
        case 1:
            action = .on
        case 2:
            action = .off
        case 3:
            action = .auto
        case 4:
            action = .down
        case 5:
            action = .up
        case 6:
            action = .cool
        case 7:
            action = .dry
        case 8:
            action = .wind
        case 9:
            action = .apply
        default:
            break
        }
        
        delegate?.btnActionTapped(action: action)
    }
    
}
