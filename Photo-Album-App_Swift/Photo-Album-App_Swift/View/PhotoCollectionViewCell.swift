//
//  PhotoCollectionViewCell.swift
//  Photo-Album-App_Swift
//
//  Created by 조중윤 on 2022/02/16.
//

import UIKit
import Photos

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailView: UIImageView!
    
    static var identifier: String {
            return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    public func updateThumbnail(with asset: PHAsset?, completionHandler: ((Bool) -> Void)?) {
        
        self.thumbnailView.fetchImageAsset(
            with: asset, size: self.thumbnailView.bounds.size,
            contentMode: .aspectFit, options: nil) { success in
                completionHandler?(success)
            }
    }

}
