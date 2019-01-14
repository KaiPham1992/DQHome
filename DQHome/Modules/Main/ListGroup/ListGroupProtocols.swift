//
//  ListRoomProtocols.swift
//  DQHome
//
//  Created Ngoc Duong on 10/30/18.
//  Copyright © 2018 Engma. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol ListGroupWireframeProtocol: class {
    
}
//MARK: Presenter -
protocol ListGroupPresenterProtocol: class {
    
    var interactor: ListGroupInteractorInputProtocol? { get set }
    func viewDidLoad()
    func groupSelected(group: GroupEntity)
}

//MARK: Interactor -
protocol ListGroupInteractorOutputProtocol: class {
    
    /* Interactor -> Presenter */
    func didGetTopGroup(groups: [GroupEntity])
}

protocol ListGroupInteractorInputProtocol: class {
    
    var presenter: ListGroupInteractorOutputProtocol?  { get set }
    
    /* Presenter -> Interactor */
    func getTopGroup()
    func groupSelected(group: GroupEntity)
}

//MARK: View -
protocol ListGroupViewProtocol: class {
    
    var presenter: ListGroupPresenterProtocol?  { get set }
    
    /* Presenter -> ViewController */
    func didGetTopGroup(groups: [GroupEntity])
}