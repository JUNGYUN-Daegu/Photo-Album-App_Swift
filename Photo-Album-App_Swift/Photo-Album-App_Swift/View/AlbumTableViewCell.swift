//
//  AlbumTableViewCell.swift
//  Photo-Album-App_Swift
//
//  Created by 조중윤 on 2022/02/16.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var photoCountLabel: UILabel!
    static var identifier: String {
            return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .red
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
}
