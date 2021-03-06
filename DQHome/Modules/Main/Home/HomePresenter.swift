//
//  HomePresenter.swift
//  DQHome
//
//  Created Ngoc Duong on 10/18/18.
//  Copyright © 2018 Engma. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HomePresenter: HomePresenterProtocol, HomeInteractorOutputProtocol {
    func didGetHomeItems(items: [Any]) {
        view?.didGetHomeItems(items: items)
    }
    
    func viewDidLoad() {
        interactor?.getHomeItems()
    }
    

    weak private var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    private let router: HomeWireframeProtocol

    init(interface: HomeViewProtocol, interactor: HomeInteractorInputProtocol?, router: HomeWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}
