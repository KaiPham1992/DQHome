//
//  ProgressView.swift
//  cihyn-ios
//
//  Created by Ngoc Duong on 10/2/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

import UIKit


open class ProgressView {
    
    let vcontainer: UIView = {
        let v = UIView()
        //        v.backgroundColor = AppColor.backgroundItem
        
        return v
    }()
    
    let vIndicator: KActivityIndicatorView = {
        let view = KActivityIndicatorView(type: KActivityIndicatorType.ballBeat)
        
        return view
    }()
    
    let lbMessage: AppLabel = {
        let lb = AppLabel()
        
        lb.backgroundColor = AppColor.backgroundMenu
        lb.setBorder(borderWidth: 1, borderColor: UIColor.white.withAlphaComponent(0.7), cornerRadius: 5)
        lb.textColor = AppColor.white
        lb.textAlignment = .center
        return lb
    }()
    
    
    public static let shared = ProgressView()
    
    private func showProgressView(_ view: UIView) {
        
        view.addSubview(vcontainer)
        vcontainer.fillSuperview()
        
        //---
        vcontainer.addSubview(lbMessage)
        lbMessage.centerSuperview()
        lbMessage.anchor(heightConstant: 40)
        lbMessage.widthAnchor.constraint(greaterThanOrEqualToConstant: 150).isActive = true
        //---
        vcontainer.addSubview(vIndicator)
        vIndicator.centerXToSuperview()
        vIndicator.anchor(lbMessage.bottomAnchor, topConstant: 0, widthConstant: 30, heightConstant: 30)
        
        vIndicator.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        vIndicator.startAnimating()
    }
    
    open func showProgress() {
        self.lbMessage.text = "      \(AppString.Loading.loadingDefault.showLanguage)...      "
        DispatchQueue.main.async {
            guard let view = UIApplication.topViewController()?.view else { return }
            self.showProgressView(view)
        }
    }
    
    func showProgress(with message: String) {
        self.lbMessage.text  = "      \(message.showLanguage)...      "
        DispatchQueue.main.async {
            guard let view = UIApplication.topViewController()?.view else { return }
            self.showProgressView(view)
        }
    }
    
    func showProgressSendSignalOnWindow() {
        self.lbMessage.text  = "      \(AppString.Loading.sendSignal.showLanguage)...      "
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.keyWindow else  { return }
            self.showProgressView(window)
        }
    }
    
    func showProgressSendSignalOnTopView() {
        self.lbMessage.text  = "      \(AppString.Loading.sendSignal.showLanguage)...      "
        DispatchQueue.main.async {
            guard let view = UIApplication.topViewController()?.view else { return }
            self.showProgressView(view)
        }
    }
    
    open func hideProgressView() {
        DispatchQueue.main.async {
            self.vcontainer.removeFromSuperview()
            self.vIndicator.removeFromSuperview()
        }
        
    }
}
