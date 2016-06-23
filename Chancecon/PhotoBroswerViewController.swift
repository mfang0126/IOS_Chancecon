//
//  PhotoBroswerViewController.swift
//  Chancecon
//
//  Created by Freedom on 21/06/16.
//  Copyright © 2016 Chancellor Construction Ltd. All rights reserved.
//

import UIKit
import SKPhotoBrowser
import FirebaseStorage
import Firebase

class PhotoBroswerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, SKPhotoBrowserDelegate  {
    
    //firebase
    var storageRef:FIRStorageReference!
    
    private final let screenBound = UIScreen.mainScreen().bounds
    private var screenWidth: CGFloat { return screenBound.size.width }
    private var screenHeight: CGFloat { return screenBound.size.height }
    @IBOutlet weak var photoCollection: UICollectionView!
    
    var images = [SKPhotoProtocol]()
    var caption = ["Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                   "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book",
                   "It has survived not only five centuries, but also the leap into electronic typesetting",
                   "remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                   "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                   "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                   "It has survived not only five centuries, but also the leap into electronic typesetting",
                   "remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                   "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                   "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                   "It has survived not only five centuries, but also the leap into electronic typesetting",
                   "remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                   ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //firebase
//        let userID = FIRAuth.auth()?.currentUser?.uid
//        storageRef = FIRStorage.storage().referenceForURL("gs://chancecon-32b5a.appspot.com")
//        if let user = FIRAuth.auth()?.currentUser {
//            if let imageUrlAll = SKPhoto.photoWithImageURL()
//        }
        
        
        for i in 0..<10 {
            let photo = SKPhoto.photoWithImage(UIImage(named: "image\(i%10).jpg")!)
            if i == 0 {
                // MARK: [BUG] this image can't be cached!!!
                photo.photoURL = "https://images.unsplash.com/photo-1451906278231-17b8ff0a8880?crop=entropy&dpr=2&fit=crop&fm=jpg&h=800&ixjsv=2.1.0&ixlib=rb-0.3.5&q=50&w=1275"
            }
            if i == 1 {
                photo.photoURL = "https://images.unsplash.com/photo-1458640904116-093b74971de9?crop=entropy&dpr=2&fit=crop&fm=jpg&h=800&ixjsv=2.1.0&ixlib=rb-0.3.5&q=50&w=1275"
            }
            photo.caption = caption[i%10]
            images.append(photo)
        }
        
        setupTableView()
    }

    private func setupTableView() {
        photoCollection.delegate = self
        photoCollection.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    

    // MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.collectionImage.image = images[indexPath.row].underlyingImage
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        guard let cell = collectionView.cellForItemAtIndexPath(indexPath) as? CollectionViewCell else {
            return
        }
        guard let originImage = cell.collectionImage.image else {
            return
        }
        let browser = SKPhotoBrowser(originImage: originImage, photos: images, animatedFromView: cell)
        browser.initializePageIndex(indexPath.row)
        browser.delegate = self
        browser.displayDeleteButton = false
        browser.statusBarStyle = .LightContent
        browser.bounceAnimation = true
        // browser.enableSingleTapDismiss = true
        
        // Can hide the action button by setting to false
        browser.displayAction = true
        
        // delete action(you must write `removePhoto` delegate, what resource you want to delete)
        // browser.displayDeleteButton = true
        
        // Optional action button titles (if left off, it uses activity controller
        // browser.actionButtonTitles = ["Do One Action", "Do Another Action"]
        
        presentViewController(browser, animated: true, completion: {})
    }
    
    // MARK: - SKPhotoBrowserDelegate
    func didShowPhotoAtIndex(index: Int) {
        photoCollection.visibleCells().forEach({$0.hidden = false})
        photoCollection.cellForItemAtIndexPath(NSIndexPath(forItem: index, inSection: 0))?.hidden = true
    }
    
    func willDismissAtPageIndex(index: Int) {
        photoCollection.visibleCells().forEach({$0.hidden = false})
        photoCollection.cellForItemAtIndexPath(NSIndexPath(forItem: index, inSection: 0))?.hidden = true
    }
    
    func willShowActionSheet(photoIndex: Int) {
        // do some handle if you need
    }
    
    func didDismissAtPageIndex(index: Int) {
        photoCollection.cellForItemAtIndexPath(NSIndexPath(forItem: index, inSection: 0))?.hidden = false
    }
    
    func didDismissActionSheetWithButtonIndex(buttonIndex: Int, photoIndex: Int) {
        // handle dismissing custom actions
    }
    
    func viewForPhoto(browser: SKPhotoBrowser, index: Int) -> UIView? {
        
        return photoCollection.cellForItemAtIndexPath(NSIndexPath(forItem: index, inSection: 0))
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSizeMake((collectionView.frame.size.width-10)/2, (collectionView.frame.size.width-10)/2)
    }
    
}





