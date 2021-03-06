//
//  LeftMenuProtocols.swift
//  DQHome
//
//  Created Ngoc Duong on 10/22/18.
//  Copyright © 2018 Engma. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol LeftMenuWireframeProtocol: class {

}
//MARK: Presenter -
protocol LeftMenuPresenterProtocol: class {

    var interactor: LeftMenuInteractorInputProtocol? { get set }
    func viewDidLoad()
}

//MARK: Interactor -
protocol LeftMenuInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func didCreatedItemMenu(listItem: [Any])
}

protocol LeftMenuInteractorInputProtocol: class {

    var presenter: LeftMenuInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
    func createItemMenu()
}

//MARK: View -
protocol LeftMenuViewProtocol: class {

    var presenter: LeftMenuPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
    func didCreatedItemMenu(listItem: [Any])
}
