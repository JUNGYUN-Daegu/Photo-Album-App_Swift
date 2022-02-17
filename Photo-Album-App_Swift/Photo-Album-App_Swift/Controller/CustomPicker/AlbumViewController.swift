//
//  AlbumViewController.swift
//  Photo-Album-App_Swift
//
//  Created by 조중윤 on 2022/02/16.
//

import UIKit
import Photos

final class AlbumViewController: UIViewController {
    private var vm: LocalPhotoManageable! = nil
    @IBOutlet weak var albumTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setRightBarButtonItem()
        self.setAlbumTableView()
    }
    
    public func inject(viewModel: LocalPhotoManageable) {
        self.vm = viewModel
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let photoVC = segue.destination as? PhotoViewController {
            guard let validAssets = vm.getTargetAssets(),
                  let validTitle = vm.getTargetTitle() else { return }
            photoVC.inject(assets: validAssets, title: validTitle)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationItem.backButtonTitle = ""
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
    
}

//MARK: - Table View Data Source
extension AlbumViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.getAlbumCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = albumTableView.dequeueReusableCell(
            withIdentifier: AlbumTableViewCell.identifier)
                as? AlbumTableViewCell else { return UITableViewCell() }
        
        let albumTitle = self.vm.getCollectionName(with: indexPath.row)
        let count = self.vm.getCollectionCount(with: indexPath.row)
        cell.update(title: albumTitle, count: count)
        
        let coverAsset = vm.getThumbnailAsset(with: indexPath.row)
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
        let fixedCellHeight: CGFloat = 85.0
        return fixedCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.vm.prepareAssetForPhotoViewer(with: indexPath.row)
        self.performSegue(withIdentifier: "ToPhotoView", sender: self)
    }
}
