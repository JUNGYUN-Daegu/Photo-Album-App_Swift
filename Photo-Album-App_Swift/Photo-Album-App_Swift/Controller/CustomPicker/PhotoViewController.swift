
//  PhotoViewController.swift
//  Photo-Album-App_Swift
//
//  Created by 조중윤 on 2022/02/16.
//

import UIKit
import Photos

class PhotoViewController: UIViewController {
    var assets: PHFetchResult<PHAsset>?
    private let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setPhotoCollectionView()
    }
    
    func prepareWith(assets: PHFetchResult<PHAsset>, title: String) {
        self.assets = assets
        self.title = title
    }
    
    func setPhotoCollectionView() {
        self.photoCollectionView.register(PhotoCollectionViewCell.nib(), forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        self.photoCollectionView.dataSource = self
        self.photoCollectionView.delegate = self
    }
    
    private func getCellSize() -> CGSize {
        let width = self.photoCollectionView.frame.width - sectionInsets.left - sectionInsets.right
        let cellSpacing: CGFloat = 4
        let itemsPerRow: CGFloat = 3
        let padding = cellSpacing * (itemsPerRow - 1)
        let cellWidth = (width - padding) / itemsPerRow
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
//MARK: - Collection View Data Source
extension PhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let validAssset = self.assets else { return 0 }
        return validAssset.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let validAssets = assets else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath as IndexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setThumbnailSize(with: getCellSize())
        cell.updateThumbnail(with: validAssets[indexPath.row]) { success in
            if !success {
                self.presentAlert(title: "ERROR: Something went wrong fetching local photo")
            }
        }
        
        return cell
    }
}

//MARK: - Collection View Delegate
extension PhotoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
    }
}

//MARK: - Collection View FlowLayout
extension PhotoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return getCellSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }

}
