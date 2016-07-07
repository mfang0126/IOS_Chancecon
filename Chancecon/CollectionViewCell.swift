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
    
    func setImageViewFromUrl(url: String) {
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        if let nsURL = NSURL(string: url) {
            session.dataTaskWithURL(nsURL, completionHandler: {
                (response: NSData?, data: NSURLResponse?, error: NSError?) in
                if error != nil {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.collectionImage.image = UIImage()
                    }
                }
                if let res = response, let image = UIImage(data: res) {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.collectionImage.image = image
                    }
                }
                session.finishTasksAndInvalidate()
            }).resume()
        }
        return
    }
}