//
//  CollectionViewCell.swift
//  Chancecon
//
//  Created by Freedom on 21/06/16.
//  Copyright © 2016 Chancellor Construction Ltd. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var collectionImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionImage.image = nil
        layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        collectionImage.image = nil
    }
}