//
//  AlbumViewController.swift
//  Photo-Album-App_Swift
//
//  Created by 조중윤 on 2022/02/16.
//

import UIKit

class AlbumViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "앨범"
        self.view.backgroundColor = .green
        
        let backToMainButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                               target: self,
                                               action: #selector(dismissToMain))
        
        navigationItem.rightBarButtonItems = [backToMainButton]
    }
    
    @objc private func dismissToMain() {
        self.dismiss(animated: true, completion: nil)
    }
}
