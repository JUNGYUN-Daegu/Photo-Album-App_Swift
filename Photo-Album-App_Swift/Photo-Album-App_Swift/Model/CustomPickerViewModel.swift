//
//  CustomPickerViewModel.swift
//  Photo-Album-App_Swift
//
//  Created by 조중윤 on 2022/02/17.
//

import Photos

protocol LocalPhotoManageable {
    func getAlbumCount() -> Int
    func prepareAssetForPhotoViewer(with index: Int)
    func getTargetAssets() -> PHFetchResult<PHAsset>?
    func getTargetTitle() -> String?
    func getThumbnailAsset(with index: Int) -> PHAsset?
    func getCollectionName(with index: Int) -> String
    func getCollectionCount(with index: Int) -> Int
}

final class CustomPickerViewModel: LocalPhotoManageable {
    private var allPhotos = PHFetchResult<PHAsset>()
    //auto generated albums
    private var smartAlbums = PHFetchResult<PHAssetCollection>()
    //user created albums
    private var userCollections = PHFetchResult<PHAssetCollection>()
    private var targetAssets: PHFetchResult<PHAsset>?
    private var targetTitle: String?
    
    init() {
        self.fetchAssets()
    }
    
    private func fetchAssets() {
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [
            NSSortDescriptor(
                key: "creationDate",
                ascending: false)
        ]
        
        self.allPhotos = PHAsset.fetchAssets(with: allPhotosOptions)
        
        self.smartAlbums = PHAssetCollection.fetchAssetCollections(
            with: .smartAlbum,
            subtype: .smartAlbumFavorites,
            options: nil)
        
        self.userCollections = PHAssetCollection.fetchAssetCollections(
            with: .album,
            subtype: .albumRegular,
            options: nil)
    }
    
    private func getCollection(with index: Int) -> PHAssetCollection {
        let adjustedIndex = index - 1
        return adjustedIndex < smartAlbums.count ? smartAlbums[adjustedIndex] : userCollections[adjustedIndex - smartAlbums.count]
    }
    
    public func getAlbumCount() -> Int {
        let allPhotoAlbumCount = 1
        return allPhotoAlbumCount + smartAlbums.count + userCollections.count
    }
    
    public func prepareAssetForPhotoViewer(with index: Int) {
        if index == 0 {
            self.targetAssets = self.allPhotos
        } else {
            let album = getCollection(with: index)
            self.targetAssets = PHAsset.fetchAssets(in: album, options: nil)
        }
        self.targetTitle = self.getCollectionName(with: index)
    }
    
    public func getTargetAssets() -> PHFetchResult<PHAsset>? {
        return self.targetAssets
    }
    
    public func getTargetTitle() -> String? {
        return self.targetTitle
    }
    
    public func getThumbnailAsset(with index: Int) -> PHAsset? {
        if index == 0 {
            return allPhotos.firstObject
        } else {
            let collection = getCollection(with: index)
            let fetchedAssets = PHAsset.fetchAssets(in: collection, options: nil)
            return fetchedAssets.firstObject
        }
    }
    
    public func getCollectionName(with index: Int) -> String {
        if index == 0 {
            return "모든 사진"
        } else {
            return self.getCollection(with: index).localizedTitle ?? ""
        }
    }
    
    public func getCollectionCount(with index: Int) -> Int {
        if index == 0 {
            return self.allPhotos.count
        } else {
            let fetchedAsset = PHAsset.fetchAssets(in: self.getCollection(with: index), options: nil)
            return fetchedAsset.count
        }
    }
    
}
