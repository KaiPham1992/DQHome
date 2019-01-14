//
//  ApolloPopUpRemoteContent.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/30/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

protocol ApolloPopUpRemoteContentDelegate: class {
    func didChangeValue(color: UIColor, brightness: CGFloat)
}

class ApolloPopUpRemoteContent: BaseViewXib {
    @IBOutlet weak var stvContent: UIStackView!
    @IBOutlet weak var btnPower: AppButton!
    @IBOutlet weak var colorWheel: ColorWheel!
    @IBOutlet weak var slideBrightness: UISlider!
    @IBOutlet weak var btnClose: UIButton!
    
    weak var delegate: ApolloPopUpRemoteContentDelegate?
    
    override func setUpViews() {
        super.setUpViews()
        addbtnColor()
        btnPower.tintColor = UIColor.red
        btnPower.setImage(AppImage.imgPower, for: .normal)
        slideBrightness.setThumbImage(AppImage.imgSliderThumb, for: .normal)
        colorWheel.delegate = self
    }
    
    func addbtnColor() {
        for (index, color) in AppColor.baseColors.enumerated() {
            let btn = UIButton()
            btn.backgroundColor = color
            btn.tag = index
            btn.addTarget(self, action: #selector(btnColorTapped), for: .touchUpInside)
            stvContent.addArrangedSubview(btn)
            
            btn.setBorder(cornerRadius: 15)
        }
    }
    
    @objc func btnColorTapped(sender: UIButton) {
        AnimationHelper.shared.animationScale(view: sender, fromScale: 1, toScale: 1.2, duration: 0.2, repeatCount: 0, autoreverses: false, completion: nil)
        colorWheel.setViewColor(AppColor.baseColors[sender.tag])
        
        delegate?.didChangeValue(color: colorWheel.color, brightness: colorWheel.brightness)
    }
    
    @IBAction func slideBrightnessChanged(sender: UISlider) {
        let tempBrightness = CGFloat(sender.value / sender.maximumValue)
        colorWheel.setViewBrightness(tempBrightness)
        delegate?.didChangeValue(color: colorWheel.color, brightness: tempBrightness)
    }
}

extension ApolloPopUpRemoteContent: ColorWheelDelegate {
    func hueAndSaturationSelected(_ hue: CGFloat, saturation: CGFloat) {
         
    }
    
    func colorSelected(color: UIColor) {
         delegate?.didChangeValue(color: colorWheel.color, brightness: colorWheel.brightness)
    }
    
    
}
