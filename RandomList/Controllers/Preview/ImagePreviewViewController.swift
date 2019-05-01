//
//  ImagePreviewViewController.swift
//  RandomList
//
//  Created by Aaqib Hussain on 24/4/19.
//  Copyright © 2019 Aaqib Hussain. All rights reserved.
//

import UIKit
import Kingfisher

class ImagePreviewViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet private weak var previewImageView: UIImageView!
    var previewImageURL: URL?
    
    //MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Functions
    
    func setupUI() {
        previewImageView.kf.setImage(with: previewImageURL)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dimissViewController))
        previewImageView.addGestureRecognizer(tap)
    }
    
    @objc func dimissViewController() {
        dismiss(animated: true, completion: nil)
    }
}
