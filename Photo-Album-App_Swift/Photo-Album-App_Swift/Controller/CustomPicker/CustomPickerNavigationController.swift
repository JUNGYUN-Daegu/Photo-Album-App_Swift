//
//  CustomPickerNavigationController.swift
//  Photo-Album-App_Swift
//
//  Created by 조중윤 on 2022/02/16.
//

import UIKit

final class CustomPickerNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customPickerViewModel = CustomPickerViewModel()
        guard let rootVC = self.viewControllers.first as? AlbumViewController else { return }
        rootVC.inject(viewModel: customPickerViewModel)
        
        self.navigationBar.tintColor = .black
        self.navigationBar.backgroundColor = .systemGray6
    }
    
}
