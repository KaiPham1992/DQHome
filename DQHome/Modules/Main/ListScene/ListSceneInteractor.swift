//
//  ListSceneInteractor.swift
//  DQHome
//
//  Created Ngoc Duong on 10/30/18.
//  Copyright © 2018 Engma. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ListSceneInteractor: ListSceneInteractorInputProtocol {
    func sendSignalScene(scene: SceneEntity) {
        //--don't have command
        if scene.content.isEmpty {
            PopUpNotificationHelper.shared.showMessage(message: "Chưa thiết lập ngữ cảnh")
        } else {
            ProgressView.shared.showProgressSendSignalOnTopView()
            Provider.shared.sceneAPIService.triggerScene(sceneId: scene.id&, success: { _baseEntity in
                 ProgressView.shared.hideProgressView()
            }) { error in
                ProgressView.shared.hideProgressView()
                PopUpNotificationHelper.shared.showMessage(error: error)
            }
        }
    }
    
    func getScene() {
        ProgressView.shared.showProgress(with: AppString.Loading.getScenes)
        Provider.shared.sceneAPIService.getScene(success: { scenes in
            ProgressView.shared.hideProgressView()
            self.presenter?.didGetScene(scenes: scenes)
        }) { error in
            ProgressView.shared.hideProgressView()
            print("error: \(error!.message&)")
        }
    }
    
    weak var presenter: ListSceneInteractorOutputProtocol?
}
