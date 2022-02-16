//
//  AlbumViewController.swift
//  Photo-Album-App_Swift
//
//  Created by 조중윤 on 2022/02/16.
//

import UIKit

class AlbumViewController: UIViewController {

    @IBOutlet weak var albumTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray
        
        self.setRightBarButtonItem()
        self.setAlbumTableView()
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = albumTableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.identifier) as? AlbumTableViewCell else { return UITableViewCell() }
                
        return cell
    }
    
    
}
//MARK: - Table View Delegate
extension AlbumViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}
