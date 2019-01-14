//
//  HomeRouter.swift
//  DQHome
//
//  Created Ngoc Duong on 10/18/18.
//  Copyright © 2018 Engma. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HomeRouter: HomeWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> HomeViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = HomeViewController.initFrom(storyboardName: ConstantStoryboard.main)
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}