
//  PhotoViewController.swift
//  Photo-Album-App_Swift
//
//  Created by 조중윤 on 2022/02/16.
//

import UIKit
import Photos

class PhotoViewController: UIViewController {
    var assets: PHFetchResult<PHAsset>?
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
    
}

extension PhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let validAssset = self.assets else { return 0 }
                return validAssset.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let validAssets = assets else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath as IndexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        
        cell.updateThumbnail(with: validAssets[indexPath.row]) { success in
            if !success {
                self.presentAlert(title: "ERROR: Something went wrong fetching local photo")
            }
        }
        
        return cell
    }
}

extension PhotoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
    }
}
