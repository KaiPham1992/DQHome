//
//  ListRoomRouter.swift
//  DQHome
//
//  Created Ngoc Duong on 10/30/18.
//  Copyright © 2018 Engma. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ListGroupRouter: ListGroupWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> ListGroupViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = ListGroupViewController.initFrom(storyboardName: ConstantStoryboard.main)
        let interactor = ListGroupInteractor()
        let router = ListGroupRouter()
        let presenter = ListGroupPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}