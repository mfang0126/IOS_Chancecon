//
//  PhotoBroswerViewController.swift
//  Chancecon
//
//  Created by Freedom on 21/06/16.
//  Copyright © 2016 Chancellor Construction Ltd. All rights reserved.
//  gs://chancecon-32b5a.appspot.com

import UIKit
import SKPhotoBrowser
import Firebase
import FirebaseAuth

class PhotoBroswerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, SKPhotoBrowserDelegate  {
    
    private final let screenBound = UIScreen.mainScreen().bounds
    private var screenWidth: CGFloat { return screenBound.size.width }
    private var screenHeight: CGFloat { return screenBound.size.height }
    @IBOutlet weak var photoCollection: UICollectionView!
    @IBAction func backButton(sender: AnyObject) {
        self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)

    }
    
    var albumType = "Foundation"
    let uid = FIRAuth.auth()?.currentUser?.uid
    var cellNumber = 0
    var images = [SKPhoto]()
    var caption = [String]()
    var url = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //albumType
        switch (Variables.albums) {
        case "Foundation":
            albumType = Variables.albums
            break
        case "Framing":
            albumType = Variables.albums
            break
        case "Cladding":
            albumType = Variables.albums
            break
        case "Interior GIB Stopping":
            albumType = Variables.albums
            break
        case "Interior Finishing":
            albumType = Variables.albums
            break
        case "Driveway&Landscape":
            albumType = Variables.albums
            break
        case "Completed":
            albumType = Variables.albums
            break
        default:
            NSLog("Not Handled")
        }
        
        //Navigation Bar
        navigationController!.navigationBar.barStyle = .Black
        
        print("\(Variables.albums)")
        
        FIRDatabase.database().reference().child("images").child(uid!).child(albumType).observeEventType(.Value, withBlock: { snapshot in
            
            if (snapshot.value == nil) {
                NSLog("No message")
            } else  {
                //fetch caption text
                var insideCaption = [String]()
                for snap in snapshot.children {
                    let caption = snap.value.objectForKey("caption") as! String
                    insideCaption.append(caption)
                }
                self.caption = insideCaption
                
                var insideUrl = [String]()
                for snap in snapshot.children {
                    let url = snap.value.objectForKey("url") as! String
                    insideUrl.append(url)
                }
                self.url = insideUrl
                self.cellNumber = self.url.count
                for i in 0..<self.cellNumber {
                    print(i)
                    let photo = SKPhoto.photoWithImageURL("http://nas.fmfreedom.com/Chancecon/ScreenShots01.png")
                    photo.caption = self.caption[i]
                    photo.photoURL = self.url[i]
                    photo.shouldCachePhotoURLImage = true
                    self.images.append(photo)
                }
                

            }
        })

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
        
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        
        FIRDatabase.database().reference().child("images").child(uid!).child(albumType).observeEventType(.Value, withBlock: { snapshot in
            if (snapshot.value == nil) {
                NSLog("No message")
            } else  {
                self.cellNumber = self.url.count
                let photo = SKPhoto.photoWithImageURL("")
                photo.caption = self.caption[0]
                photo.photoURL = self.url[0]
                photo.shouldCachePhotoURLImage = true
                self.images.append(photo)
                cell.setImageViewFromUrl(self.url[indexPath.row])
            }
        })
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
        browser.displayCounterLabel = false
        browser.statusBarStyle = .LightContent
        browser.bounceAnimation = true
        browser.displayBackAndForwardButton = false
        
        // Can hide the action button by setting to false
        browser.displayAction = true
        
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




