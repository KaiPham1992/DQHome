//
//  HomeProtocols.swift
//  DQHome
//
//  Created Ngoc Duong on 10/18/18.
//  Copyright © 2018 Engma. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol HomeWireframeProtocol: class {

}
//MARK: Presenter -
protocol HomePresenterProtocol: class {

    var interactor: HomeInteractorInputProtocol? { get set }
    func viewDidLoad()
}

//MARK: Interactor -
protocol HomeInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func didGetHomeItems(items: [Any])
}

protocol HomeInteractorInputProtocol: class {

    var presenter: HomeInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
    func getHomeItems()
}

//MARK: View -
protocol HomeViewProtocol: class {

    var presenter: HomePresenterProtocol?  { get set }

    /* Presenter -> ViewController */
    func didGetHomeItems(items: [Any])
}
