//
//  ViewController.swift
//  Photo-Album-App_Swift
//
//  Created by 조중윤 on 2022/02/15.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTapBuiltInImagePickerButton(_ sender: UIButton) {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = .photoLibrary
        pickerController.delegate = self
        self.present(pickerController, animated: true)
    }
    
    @IBAction func didTapCustomImagePickerButton(_ sender: UIButton) {
        print("Did tap custom image picker button")
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
            sizeInfo = String.localizedStringWithFormat("파일크기 : %d MB", imageSize / 1_000_000)
        }
        
        picker.presentAlert(
            title: "사진정보", message: "\(nameInfo)\n\(sizeInfo)",
            confirmTitle: "확인", confirmHandler: nil,
            cancelTitle: nil, cancelHandler: nil,
            completion: nil, autodismiss: nil)
    }
    
}
