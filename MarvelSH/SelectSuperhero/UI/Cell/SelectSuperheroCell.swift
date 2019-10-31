//
//  SelectSuperheroCell.swift
//  MarvelSH
//
//  Created by Pablo Ramirez on 10/29/19.
//  Copyright © 2019 Pablo Ramirez. All rights reserved.
//

import UIKit

class SelectSuperheroCell: UICollectionViewCell {

    @IBOutlet weak var contentViewCell: UIView?
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var nameSuperheroLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(urlImage: String, nameSuperhero: String) {
        contentViewCell?.layer.cornerRadius = 5
        contentViewCell?.layer.borderColor = UIColor.lightGray.cgColor
        contentViewCell?.layer.borderWidth = 1
        
        imageView?.imageFromServerURL(urlImage, placeHolder: imageView?.image)
        nameSuperheroLabel?.text = nameSuperhero
    }
}
