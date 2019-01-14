//
//  File.swift
//  DQHome
//
//  Created by Ngoc Duong on 12/4/18.
//  Copyright © 2018 Engma. All rights reserved.
//


import UIKit

protocol SelectPhotoCanCropPopUpDelegate: class {
    func didReceivePhoto(image: UIImage)
}

class SelectPhotoCanCropPopUp: NSObject {
    
    var controller: UIViewController?
    weak var delegate: SelectPhotoCanCropPopUpDelegate?
    var imagePickerUIKit = UIImagePickerController()
    init(controller: UIViewController, delegate: SelectPhotoCanCropPopUpDelegate) {
        self.controller = controller
        self.delegate = delegate
    }
    
    func showCropPicker() {
        let popUp = ChooseImagePopUp()
        popUp.delegate = self
        popUp.showPopUp(width: 300, height: 200, type: .zoomOut)
    }
    
    private func presentImagePicker(sourceType: UIImagePickerControllerSourceType) {
        
        guard let controller = controller else { return }
        imagePickerUIKit = UIImagePickerController()
        imagePickerUIKit.delegate = self
        imagePickerUIKit.sourceType = sourceType
        controller.present(imagePickerUIKit, animated: true, completion: nil)
    }
}

extension SelectPhotoCanCropPopUp: ChooseImagePopUpDelegate {
    
    func btnCameraTapped() {
        presentImagePicker(sourceType: .camera)
    }
    
    func btnGalaryTapped() {
      presentImagePicker(sourceType: .photoLibrary)
    }
    
}

// MARK:
extension SelectPhotoCanCropPopUp: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let imageEdit = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        imagePickerUIKit.dismiss(animated: true, completion: nil)
        delegate?.didReceivePhoto(image: imageEdit.resizeImage(maxWidth: 1334))
    }
}
