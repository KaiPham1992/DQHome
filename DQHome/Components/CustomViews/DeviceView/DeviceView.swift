//
//  DeviceView.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/24/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

enum DeviceViewAction {
    case normal
    case move
    case changeSize
}

class DeviceView: BaseView {
    let btnAction: UIButton = {
        let btn = UIButton()
        
        return btn
    }()
    
    let imgIcon: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.tintColor = AppColor.gray
        
        return img
    }()
    
    let imgWarning: UIImageView = {
        let img = UIImageView()
        img.image = AppImage.imgWarning
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let lbDeviceName: AppLabel = {
        let lb = AppLabel()
        lb.numberOfLines = 2
        lb.textAlignment = .center
        lb.textColor = AppColor.white
        lb.font = AppFont.fontRegular11
        lb.sizeToFit()
        
        return lb
    }()
    
    var deviceViewAction = DeviceViewAction.normal
    weak var delegate: DeviceViewDelegate?
    var longGesture: UILongPressGestureRecognizer!
    var panGesture : UIPanGestureRecognizer!
    
    var deviceData: DeviceData? {
        didSet {
            guard let _device = deviceData else { return }
            lbDeviceName.text = _device.name&
            
            getOnlineOfflineMCE()
            addLongGesture()
            getOnlineOfflineSwitchV2()
            getOnlineOfflineAPollo { color in
                
            }
        }
    }
    
    // to status MCE device
    var mceDevice: MCEDevice? {
        didSet {
            guard let _device = mceDevice else { return }
            self.imgWarning.isHidden = _device.isOnline
        }
    }
    
    // to status APolloDevice
    var apolloDevice: APolloDevice? {
        didSet {
            guard let _device = apolloDevice else { return }
            self.imgWarning.isHidden = _device.isOnline
        }
    }
    
    // to status SwitchV2Entity
    var switchV2: SwitchV2Entity? {
        didSet {
            guard let _device = switchV2 else { return }
            self.imgWarning.isHidden = _device.isConnecting
        }
    }
    
    // to status curtain
    var curtain: CurtainEntity? {
        didSet {
            guard let _device = curtain else { return }
            self.imgWarning.isHidden = _device.isConnecting
        }
    }
    
    // On = light
    var isOn: Bool = false {
        didSet {
            self.imgIcon.image = isOn == true ? AppImage.imgMCELight: nil
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        self.addSubview(imgIcon)
        self.addSubview(lbDeviceName)
        self.addSubview(imgWarning)
        self.addSubview(btnAction)
        
        imgIcon.fillSuperview()
        
        lbDeviceName.anchor(imgIcon.bottomAnchor, topConstant: 5)
        lbDeviceName.centerXToSuperview()
        imgWarning.anchor(widthConstant: 10, heightConstant: 10)
        imgWarning.centerSuperview()
        
        //---
        btnAction.addTarget(self, action: #selector(btnDeviceTapped), for: .touchUpInside)
        btnAction.fillSuperview()
    }
    
    @objc func btnDeviceTapped(sender: UIButton) {
        guard let type = deviceData?.type else { return }
        
        switch type {
        case .mce:
            tapMCE()
        case .apollo:
            tapApollo()
        case .iRDevice:
            switch self.deviceData?.devType& {
            case EditDeviceType.tv.rawValue:
                tvControl()
                break
            case EditDeviceType.conditioner.rawValue:
                airControl()
            case EditDeviceType.projector.rawValue:
                print("projector")
            case EditDeviceType.dimable.rawValue:
                print("dimable")
            default:
                // not map type
                let popUpEditTypeDevice = ListItemPopUp()
                popUpEditTypeDevice.showPopUp(listItem: [
                    EditDeviceType.tv, EditDeviceType.conditioner, EditDeviceType.projector, EditDeviceType.dimable]) { item in
                        guard let _item = item as? EditDeviceType else { return }
                        self.deviceData?.type = .iRDevice
                        self.deviceData?.metaData = _item.rawValue
                        
                }
            }
        case .curtainControl:
            curtainControl()
        case .lightSwitch:
            tapSwitchV2()
        default:
            break 
        }
    }
}

