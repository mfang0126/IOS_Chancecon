//
//  GalleryViewController.swift
//  Chancecon
//
//  Created by Freedom on 20/06/16.
//  Copyright © 2016 Chancellor Construction Ltd. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var galleryList: UITableView!
    
    var galleryTitle: [String] = ["Foundation","Framing", "Cladding", "Interior GIB Stopping", "Interior Finishing", "Driveway&Landscape","Completed"]
    var galleryDescription: [String] = ["Step One", "Step Two", "Step Three", "Step Four", "Step Five", "Step Six", "Step Seven"]
    var images = [UIImage(named:"AlbumExample"), UIImage(named:"AlbumExample"), UIImage(named:"AlbumExample"), UIImage(named:"AlbumExample"), UIImage(named:"AlbumExample"), UIImage(named:"AlbumExample"), UIImage(named:"AlbumExample")]
    
    @IBAction func MenuButtonTapped(sender: AnyObject) {
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //Navigation Customization
        navigationController!.navigationBar.barStyle = .Black
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return galleryTitle.count
    }
    
    func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let imageCell = self.galleryList.dequeueReusableCellWithIdentifier("ImageCell", forIndexPath: indexPath) as! CustomCell
        
        imageCell.cellPhoto.image = images[indexPath.row]
        imageCell.cellTitle.text = galleryTitle[indexPath.row]
        imageCell.cellDescription.text = galleryDescription[indexPath.row]
        return imageCell
    }

//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
