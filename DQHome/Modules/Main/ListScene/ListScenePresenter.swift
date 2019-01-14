//
//  ListScenePresenter.swift
//  DQHome
//
//  Created Ngoc Duong on 10/30/18.
//  Copyright © 2018 Engma. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ListScenePresenter: ListScenePresenterProtocol, ListSceneInteractorOutputProtocol {
    func cellTapped(scene: SceneEntity) {
        interactor?.sendSignalScene(scene: scene)
    }
    
    func didGetScene(scenes: [SceneEntity]) {
        view?.didGetScene(scenes: scenes)
    }
    
    func viewDidLoad() {
        interactor?.getScene()
    }
    

    weak private var view: ListSceneViewProtocol?
    var interactor: ListSceneInteractorInputProtocol?
    private let router: ListSceneWireframeProtocol

    init(interface: ListSceneViewProtocol, interactor: ListSceneInteractorInputProtocol?, router: ListSceneWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}
