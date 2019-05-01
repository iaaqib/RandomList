//
//  RandomListTableViewCell.swift
//  RandomList
//
//  Created by Aaqib Hussain on 24/4/19.
//  Copyright © 2019 Aaqib Hussain. All rights reserved.
//

import UIKit
import Kingfisher

class RandomListTableViewCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet private var brandImageView: UIImageView!
    @IBOutlet private var descriptionLabel: UILabel!
    
    //MARK: - Functions
    
    func populateCell(_ model: Products) {
        brandImageView.kf.setImage(with: model.image?.asURL)
        descriptionLabel.text = model.productDescription()
    }
}
