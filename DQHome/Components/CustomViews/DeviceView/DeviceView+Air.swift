//
//  Device+Air.swift
//  DQHome
//
//  Created by Kai Pham on 1/3/19.
//  Copyright © 2019 Engma. All rights reserved.
//

import Foundation

extension DeviceView {
    func airControl() {
        let popUp = AIRPopUpRemote()
        popUp.showPopUp { any in
            print(any)
        }
    }
}


