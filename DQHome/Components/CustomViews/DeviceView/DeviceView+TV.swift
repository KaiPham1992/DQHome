//
//  DeviceView+TV.swift
//  DQHome
//
//  Created by Ngoc Duong on 12/16/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import Foundation

extension DeviceView {
    func tvControl() {
        let pop = TVRemotePopUp()
        pop.showPopUp { any in
            print(any)
        }
    }
}
