//
//  AlbumTableViewCell.swift
//  Photo-Album-App_Swift
//
//  Created by 조중윤 on 2022/02/16.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var photoCountLabel: UILabel!
    static var identifier: String {
            return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setDefaultThumbnail()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    private func setDefaultThumbnail() {
        self.thumbnailView.image = UIImage(systemName: "photo")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
    }
    
    public func update(title: String, count: Int) {
        self.albumTitleLabel.text = title
        self.photoCountLabel.text = "\(count)"
    }
    
    public func updateThumbnail(with image: UIImage?) {
        if let validImage = image {
            self.thumbnailView.image = validImage
        }
    }
    
}
