//
//  RightMenuInteractor.swift
//  DQHome
//
//  Created Ngoc Duong on 10/22/18.
//  Copyright © 2018 Engma. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class RightMenuInteractor: RightMenuInteractorInputProtocol {
    func createItemMenu() {
        let itemMenu = ["Thiết lập", "Lưu dữ liệu", "Tải dữ liệu", "Đổi mật khẩu", "Thiết bị" ]
        presenter?.didCreatedItemMenu(listItem: itemMenu)
    }

    weak var presenter: RightMenuInteractorOutputProtocol?
}
