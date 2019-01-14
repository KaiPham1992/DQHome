//
//  SubRoomCell.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 11/5/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

class SubRoomCell: BaseCollectionCell {
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.maximumZoomScale = 5
        scroll.minimumZoomScale = 1
        scroll.clipsToBounds = true
        return scroll
    }()
    
    let vContent: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let imgBackground: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        img.image = AppImage.imgBackground
        return img
    }()
    
    let lbRoomName: AppLabel = {
        let lb = AppLabel()
        lb.textColor = AppColor.white
        lb.backgroundColor = AppColor.backgroundItem
        return lb
    }()
    
    lazy var btnEditRoom: UIButton = {
        let btn = UIButton()
        btn.setImage(AppImage.imgSetting, for: .normal)
        return btn
    }()
    
    lazy var btnSaveRoom: UIButton = {
        let btn = UIButton()
        btn.setTitle("Lưu", for: .normal)
        btn.addTarget(self, action: #selector(btnSaveRoomTapped), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    var group: GroupEntity?
    var picker: SelectPhotoCanCropPopUp?
    
    func setData(group: GroupEntity?, parentGroup: GroupEntity?) {
        guard let _group = group, let _parentGroup = parentGroup else { return }
        self.group = _group
        let roomName = "  \(_parentGroup.name&) - \(_group.name&)"
        lbRoomName.text = "  \(roomName)"
        
        //--- _parentGroup only get name
        if !_group.listRoomData.isEmpty {
            let roomData = _group.listRoomData[0]
            if let background = roomData.getBackground() {
                imgBackground.image = background
                DataManager.shared.sizeBackground = background.size
            }
            
            addDeviceToRoom(roomData: roomData)
            
        } else {
            removeAllDevice()
            imgBackground.image = AppImage.imgBackgroundDemo
            DataManager.shared.sizeBackground = AppImage.imgBackgroundDemo.size
        }
    }
    
//    var listDeviceView = [DeviceView]()
    
    override func setupViews() {
        scrollView.delegate = self
        addSubview(scrollView)
        addSubview(btnEditRoom)
        addSubview(lbRoomName)
        addSubview(btnSaveRoom)
        scrollView.fillHorizontalSuperview()
        scrollView.centerYToSuperview()
        scrollView.heightAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 9/16).isActive = true
        
        scrollView.addSubview(vContent)
        
        let doubleGesture = UITapGestureRecognizer(target: self , action:  #selector(doubleTapped))
        doubleGesture.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleGesture)
        //---
        
        vContent.frame = XMLHelper.shared.frameScreen
        vContent.addSubview(imgBackground)
        imgBackground.fillSuperview()
        
        //--
        lbRoomName.anchor(left: vContent.leftAnchor, bottom: vContent.bottomAnchor, right: vContent.rightAnchor, leftConstant: 50, bottomConstant: 5, rightConstant: 50, heightConstant: 30)
        
        btnEditRoom.anchor(right: self.rightAnchor, rightConstant: 10, widthConstant: 30, heightConstant: 30)
        btnEditRoom.centerYToView(view: self.lbRoomName)
        btnEditRoom.addTarget(self, action: #selector(btnBtnEditTapped), for: .touchUpInside)
        
        //        addLongGesture()
        
        btnSaveRoom.anchor(right: self.btnEditRoom.leftAnchor, rightConstant: 30, widthConstant: 40, heightConstant: 40)
        btnSaveRoom.centerYToView(view: self.btnEditRoom)
    }
    
    @objc func doubleTapped(gesture: UITapGestureRecognizer) {
        self.scrollView.zoomScale = 1.0
    }
    
    @objc func btnBtnEditTapped() {
        DataManager.shared.isEditRoom = true
        let popUpEditRoomType = ListItemPopUp()
        popUpEditRoomType.showPopUp(listItem: [EditRoomType.addDevice, EditRoomType.changeBackground]) { (item) in
            guard let type = item as? EditRoomType else { return }
            switch type {
            case .addDevice:
                ProgressView.shared.showProgress()
                self.getDevice(completion: { any in
                    ProgressView.shared.hideProgressView()
                    guard let listItem = any as? [DeviceData] else { return }
                    
                    let popUpDevice = ListItemPopUp()
                    popUpDevice.showPopUp(listItem: listItem, completion: { deviceData in
                        if let _deviceData = deviceData as? DeviceData {
                            self.addNewDevice(deviceData: _deviceData)
                        }
                    })
                })
            case .changeBackground:
                self.showCropPicker()
            }
        }
        
    }
    
    @objc func btnSaveRoomTapped() {
        guard let _group = group else { return }
        
//        let listDeviceData = self.listDeviceView.compactMap {$0.deviceData}
        var listDeviceData = [DeviceData]()// = vContent.subviews.filter{$0 is DeviceData}
        
        vContent.subviews.forEach { _subView in
            if let _deviceView = _subView as? DeviceView, let _deviceData = _deviceView.deviceData {
                listDeviceData.append(_deviceData)
            }
        }
        
        let svg = SvgData(image: self.imgBackground.image!, listDevice: listDeviceData)
        let roomData = RoomData(svg: svg)
        
        if let groupId = _group.id {
            let fileName = "\(groupId)_1"
            FileManagerHelper.writeSvgFromRoomData(roomData: roomData, fileName: fileName)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let digestData = FileManagerHelper.md5Base64(fileName: fileName)
                
                ProgressView.shared.showProgress(with: AppString.Loading.saveData)
                
                Provider.shared.resourceAPIService.uploadResourceStepOne(groupId: "\(groupId)", slot: 0, md5: digestData, success: { resource in
                    var header = [String: String]()
                    header["Content-MD5"] = digestData

                    Provider.shared.resourceAPIService.uploadResourceStepTwo(fileName: fileName, url: resource!.url&, header: header, success: { resoure in
                        ProgressView.shared.hideProgressView()
                        PopUpNotificationHelper.shared.showMessage(message: "Thay đổi thành công")
                        UserDefaultHelper.shared.saveTimeStamp(groupId: groupId, slot: 1, timeStamp: UInt64(Date().timeIntervalSince1970))
                    }, failure: { error in
                        ProgressView.shared.hideProgressView()
                        PopUpNotificationHelper.shared.showMessage(message: "Thay đổi thành công")
                        UserDefaultHelper.shared.saveTimeStamp(groupId: groupId, slot: 1, timeStamp: UInt64(Date().timeIntervalSince1970))
                    })

                }, failure: { error in
                    print("Sub room cell uploadResource: ")
                    ProgressView.shared.hideProgressView()
                })
            }
            
        }
    }
}

extension SubRoomCell {
    
    func addDeviceToRoom(roomData: RoomData) {
        // remove device to render again
        removeAllDevice()
        
        if let listDevice = roomData.svg?.listDevice {
            for (index, deviceData) in listDevice.enumerated() {
                let newDeviceView = DeviceView()
                newDeviceView.delegate = self
                newDeviceView.deviceData = deviceData
                newDeviceView.btnAction.tag = index
                if let _frame = deviceData.frameInMobile {
                    newDeviceView.frame = _frame
                }
                
                vContent.addSubview(newDeviceView)
//                self.listDeviceView.append(newDeviceView)
            }
        }
    }
    
    func removeAllDevice() {
        vContent.subviews.forEach { subView in
            if subView != imgBackground {
                subView.removeFromSuperview()
            }
        }
    }
}

// ZOOM
extension SubRoomCell : UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.vContent
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
        let subView = scrollView.subviews[0] // get the image view
        
        let tempX = (scrollView.bounds.size.width - scrollView.contentSize.width ) * 0.5
        let tempY = (scrollView.bounds.size.height - scrollView.contentSize.height ) * 0.5
        
        let offsetX = CGFloat.maximum(tempX, 0)
        let offsetY = CGFloat.maximum(tempY, 0)
        
        subView.center = CGPoint(x: scrollView.contentSize.width * 0.5 + offsetX, y: scrollView.contentSize.height * 0.5 + offsetY)
    }
    
}
