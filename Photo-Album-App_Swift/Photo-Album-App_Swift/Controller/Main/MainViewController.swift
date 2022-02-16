//
//  ViewController.swift
//  Photo-Album-App_Swift
//
//  Created by 조중윤 on 2022/02/15.
//

import UIKit
import Photos

final class MainViewController: UIViewController {

    @IBOutlet weak var builtInImagePickerButton: UIButton!
    @IBOutlet weak var customImagePickerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getPermissionIfNecessary { [unowned self] granted in
            if granted {
                self.builtInImagePickerButton.isHidden = false
                self.customImagePickerButton.isHidden = false
            } else {
                self.builtInImagePickerButton.isHidden = true
                self.customImagePickerButton.isHidden = true
            }
        }
    }

    @IBAction func didTapBuiltInImagePickerButton(_ sender: UIButton) {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = .photoLibrary
        pickerController.delegate = self
        self.present(pickerController, animated: true)
    }
    
    private func getPermissionIfNecessary(completionHandler: @escaping (Bool) -> Void) {
        guard PHPhotoLibrary.authorizationStatus() != .authorized else {
          completionHandler(true)
          return
        }
        
        PHPhotoLibrary.requestAuthorization { status in
          completionHandler(status == .authorized)
        }
    }
    
}

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var nameInfo = ""
        var sizeInfo = ""
        
        // referenceURL deprecated
        if let imageURL = info[.referenceURL] as? URL {
            let fileName = imageURL.lastPathComponent
            nameInfo = "파일명 : \(fileName)"
        }
        
        if let image = info[.originalImage] as? UIImage {
            let imgData = NSData(data: image.jpegData(compressionQuality: 1)!)
            let imageSize: Int = imgData.count // unit: byte
            let sizeString = String(format: "%.2f", Double(imageSize) / (1024.0*1024.0))+" MB"
            sizeInfo = sizeString
        }

        picker.presentAlert(
            title: "사진정보", message: "\(nameInfo)\n\(sizeInfo)",
            confirmTitle: "확인", confirmHandler: nil,
            cancelTitle: nil, cancelHandler: nil,
            completion: nil, autodismiss: nil)
    }
 
}
