//
//  UIImageView.swift
//  Photo-Album-App_Swift
//
//  Created by 조중윤 on 2022/02/16.
//

import UIKit
import Photos

extension UIImageView {
    func fetchImageAsset(
        with asset: PHAsset?, size: CGSize,
        contentMode: PHImageContentMode,
        options: PHImageRequestOptions?, completionHandler: ((Bool) -> Void)?) {
            
            guard let asset = asset else {
                self.setAsDefaultThumbnail()
                completionHandler?(true)
                return
            }
            
            let resultHandler: (UIImage?, [AnyHashable: Any]?) -> Void = { [weak self] image, info in
                guard let self = self else { return }
                
                self.image = image
                completionHandler?(true)
            }
            
            PHImageManager.default().requestImage(
                for: asset,
                   targetSize: size,
                   contentMode: contentMode,
                   options: options,
                   resultHandler: resultHandler)
        }
    
    func setAsDefaultThumbnail() {
        self.image = UIImage(systemName: "photo")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
    }
}


