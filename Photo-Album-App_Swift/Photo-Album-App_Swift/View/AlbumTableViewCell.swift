//
//  AlbumTableViewCell.swift
//  Photo-Album-App_Swift
//
//  Created by 조중윤 on 2022/02/16.
//

import UIKit
import Photos

class AlbumTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var photoCountLabel: UILabel!
    
    static var identifier: String {
            return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    public func update(title: String, count: Int) {
        self.albumTitleLabel.text = title
        self.photoCountLabel.text = "\(count)"
    }
    
    public func updateThumbnail(with asset: PHAsset?, completionHandler: ((Bool) -> Void)?) {
        
        self.thumbnailView.fetchImageAsset(
            with: asset, size: self.thumbnailView.bounds.size,
            contentMode: .aspectFit, options: nil) { success in
                completionHandler?(success)
            }
    }

}
