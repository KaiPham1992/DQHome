//
//  ListImageRoomView.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/30/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

protocol ListImageRoomViewDelegate: class {
    func imageRoomSelected(index: Int)
}

class ListImageRoomView: BaseView {
    var cvPhoto: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        layout.scrollDirection = .horizontal
        
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        cv.semanticContentAttribute = .forceRightToLeft
        return cv
    }()
    
    weak var delegate: ListImageRoomViewDelegate?
    
    var group: GroupEntity = GroupEntity() {
        didSet {
            cvPhoto.reloadData()
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        addSubview(cvPhoto)
        cvPhoto.fillSuperview()
        configureCollection()
    }
}

extension ListImageRoomView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    //delegate
    func configureCollection() {
        cvPhoto.register(ListImageRoomViewCell.self)
        cvPhoto.delegate = self
        cvPhoto.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        return CGSize(width: height, height: height)
    }
    
    // data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return group.listRoomData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvPhoto.dequeue(ListImageRoomViewCell.self, for: indexPath)
        
        cell.roomData = group.listRoomData[indexPath.item]
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.imageRoomSelected(index: indexPath.item)
    }
    
}
