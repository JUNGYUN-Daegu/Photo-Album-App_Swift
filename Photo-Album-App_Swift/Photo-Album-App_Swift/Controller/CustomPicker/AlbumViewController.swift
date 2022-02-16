//
//  AlbumViewController.swift
//  Photo-Album-App_Swift
//
//  Created by 조중윤 on 2022/02/16.
//

import UIKit
import Photos

class AlbumViewController: UIViewController {
    private var allPhotos = PHFetchResult<PHAsset>()
    //auto generated albums
    private var smartAlbums = PHFetchResult<PHAssetCollection>()
    //user created albums
    private var userCollections = PHFetchResult<PHAssetCollection>()
    
    @IBOutlet weak var albumTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray
        
        self.setRightBarButtonItem()
        self.setAlbumTableView()
        self.fetchAssets()
    }

    private func setRightBarButtonItem() {
        let backToMainButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                               target: self,
                                               action: #selector(dismissToMain))
        
        navigationItem.rightBarButtonItems = [backToMainButton]
    }
    
    private func setAlbumTableView() {
        self.albumTableView.register(AlbumTableViewCell.nib(), forCellReuseIdentifier: AlbumTableViewCell.identifier)
        self.albumTableView.dataSource = self
        self.albumTableView.delegate = self
    }
    
    @objc private func dismissToMain() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func fetchAssets() {
        
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [
          NSSortDescriptor(
            key: "creationDate",
            ascending: false)
        ]
        
        allPhotos = PHAsset.fetchAssets(with: allPhotosOptions)
        
        smartAlbums = PHAssetCollection.fetchAssetCollections(
          with: .smartAlbum,
          subtype: .albumRegular,
          options: nil)
        
        userCollections = PHAssetCollection.fetchAssetCollections(
          with: .album,
          subtype: .albumRegular,
          options: nil)
    }
}

//MARK: - Table View Data Source
extension AlbumViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return smartAlbums.count + userCollections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = albumTableView.dequeueReusableCell(
            withIdentifier: AlbumTableViewCell.identifier
        ) as? AlbumTableViewCell else { return UITableViewCell() }
                
        var coverAsset: PHAsset?
        let collection = indexPath.row < smartAlbums.count ? smartAlbums[indexPath.row] : userCollections[indexPath.row - smartAlbums.count]
        let fetchedAssets = PHAsset.fetchAssets(in: collection, options: nil)
        coverAsset = fetchedAssets.firstObject
        cell.update(title: collection.localizedTitle ?? "Error", count: fetchedAssets.count)
        
        cell.updateThumbnail(with: coverAsset) { success in
            if !success {
                self.presentAlert(title: "ERROR: Something went wrong fetching local photo")
            }
        }
        
        return cell
    }
    
    
}
//MARK: - Table View Delegate
extension AlbumViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}
