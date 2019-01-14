//
//  LeftMenuPresenter.swift
//  DQHome
//
//  Created Ngoc Duong on 10/22/18.
//  Copyright © 2018 Engma. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class LeftMenuPresenter: LeftMenuPresenterProtocol, LeftMenuInteractorOutputProtocol {

    func viewDidLoad() {
        interactor?.createItemMenu()
    }
    
    func didCreatedItemMenu(listItem: [Any]) {
        view?.didCreatedItemMenu(listItem: listItem)
    }
    

    weak private var view: LeftMenuViewProtocol?
    var interactor: LeftMenuInteractorInputProtocol?
    private let router: LeftMenuWireframeProtocol

    init(interface: LeftMenuViewProtocol, interactor: LeftMenuInteractorInputProtocol?, router: LeftMenuWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}