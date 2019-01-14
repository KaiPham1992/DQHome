//
//  MECPopUpRemote.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/26/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

class MECPopUpRemoteContent: BaseViewXib {
    @IBOutlet weak var switchOne: AppSwitch!
    @IBOutlet weak var switchTwo: AppSwitch!
    @IBOutlet weak var switchThree: AppSwitch!
    @IBOutlet weak var switchFour: AppSwitch!
    @IBOutlet weak var btnClose: UIButton!
    
    override func setUpViews() {
        super.setUpViews()
    }
    
    func changeStatus(startStatus: String?) {
        let listBool = startStatus&.split(separator: ":")
        if listBool.count >= 4 {
            switchOne.isOn = listBool[0].description == "ON"
            switchTwo.isOn =  listBool[1].description == "ON"
            switchThree.isOn = listBool[2].description == "ON"
            switchFour.isOn = listBool[3].description == "ON"
        }
    }
}
