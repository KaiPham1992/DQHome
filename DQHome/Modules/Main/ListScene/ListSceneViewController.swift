//
//  ListSceneViewController.swift
//  DQHome
//
//  Created Ngoc Duong on 10/30/18.
//  Copyright © 2018 Engma. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ListSceneViewController: BaseViewController, ListSceneViewProtocol {
    
    @IBOutlet weak var cvScene: UICollectionView!
    var presenter: ListScenePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    var listScene = [SceneEntity]() {
        didSet {
            cvScene.reloadData()
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        configureCollection()
    }
}

// MARK: receive data
extension ListSceneViewController {
    func didGetScene(scenes: [SceneEntity]) {
        self.listScene = scenes
    }
}

extension ListSceneViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func configureCollection() {
        cvScene.dataSource = self
        cvScene.delegate = self
        cvScene.registerXibFile(SceneCell.self)
        
        if let layout = cvScene.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 2
            layout.minimumInteritemSpacing = 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listScene.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item != listScene.count {
            let cell = cvScene.dequeue(SceneCell.self, for: indexPath)
            cell.item = listScene[indexPath.item]
            cell.imgIcon.image = nil
            cell.imgIconScene.image = AppImage.imgBackHome
            return cell
        } else {
            let cell = cvScene.dequeue(SceneCell.self, for: indexPath)
            cell.imgIcon.image = AppImage.imgAdd
            cell.imgIconScene.image = nil
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item < self.listScene.count {
            presenter?.cellTapped(scene: self.listScene[indexPath.item])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (cvScene.frame.width - 6 ) / 4
        
        return CGSize(width: width, height: width)
    }
    
    
}