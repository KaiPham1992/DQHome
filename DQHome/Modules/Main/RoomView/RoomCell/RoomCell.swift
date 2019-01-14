//
//  RoomCell.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/24/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

class RoomCell: BaseCollectionCell {
    var cvRoom: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        
        return cv
    }()
    
    var group: GroupEntity?
    
    func showData(group: GroupEntity?, room: Int) {
        guard let _ = group else { return }
        self.group = group
        cvRoom.reloadData()
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(cvRoom)
        cvRoom.fillSuperview()
        
        //--
        configureCollection()
    }
}

extension RoomCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    //delegate
    func configureCollection() {
        cvRoom.register(SubRoomCell.self)
        cvRoom.delegate = self
        cvRoom.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.cvRoom.frame.size
    }
    
    // data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let _group = group else { return 0}
        return _group.children.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvRoom.dequeue(SubRoomCell.self, for: indexPath)
        cell.setData(group: group?.children[indexPath.item], parentGroup: self.group)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        delegate?.imageRoomSelected(index: indexPath.item)
    }
    
}
