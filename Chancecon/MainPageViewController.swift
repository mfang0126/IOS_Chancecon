//
//  MainPageViewController.swift
//  Chancecon
//
//  Created by Freedom on 18/06/16.
//  Copyright © 2016 Chancellor Construction Ltd. All rights reserved.
//

import UIKit
import CircleProgressBar


class MainPageViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var progressBarOut:CircleProgressBar?
    var progressBarIn:CircleProgressBar?


    @IBAction func MenuButtonTapped(sender: AnyObject) {
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation Bar Style
        navigationController!.navigationBar.barStyle = .Black
        
        //Progress Bar Style
//        progressBarIn!.setProgress(0.7, animated: true)
//        progressBarOut!.setProgress(0.5, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

}