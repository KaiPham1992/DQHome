//
//  RoomViewController.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/23/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit
import XMLMapper

class RoomViewController: BaseViewController {
    @IBOutlet weak var cvHome: UICollectionView!
    
    var listGroup = [Any]() {
        didSet {
            cvHome.reloadData()
        }
    }
    
    var currentRoom = 0
    
    func showRoom(listRoom: [Any], floor: Int, room: Int) {
        self.listGroup = listRoom
        currentRoom = room
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            let index = IndexPath(item: floor, section: 0)
            self.cvHome.scrollToItem(at: index, at: .top, animated: true)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.isStatusBarHidden = true
    }
    
    override func setUpViews() {
        super.setUpViews()
        configureCollection()
    }
}

extension RoomViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func configureCollection() {
        cvHome.delegate = self
        cvHome.dataSource = self
        cvHome.register(RoomCell.self)
        cvHome.isPagingEnabled = true
        
        if let layout = cvHome.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listGroup.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(RoomCell.self, for: indexPath)
        if let room = listGroup[indexPath.item] as? GroupEntity {
            cell.showData(group: room, room: currentRoom)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.cvHome.frame.size
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int ( targetContentOffset.pointee.x / cvHome.frame.width )
        currentRoom = index
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.cvHome.collectionViewLayout.invalidateLayout()
            if self.currentRoom == 0 {
                self.cvHome.contentOffset = .zero
            } else {
                let indexPath = IndexPath(item: self.currentRoom, section: 0)
                self.cvHome.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            }
        })
    }
    
}
