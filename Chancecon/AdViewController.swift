//
//  AdViewController.swift
//  Chancecon
//
//  Created by Freedom on 17/06/16.
//  Copyright © 2016 Chancellor Construction Ltd. All rights reserved.
//

import UIKit

class AdViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.sharedApplication().openURL(NSURL(string: "Http://chancecon.co.nz")!)
    }
    
    override func viewDidAppear(animated: Bool) {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: ViewController = storyboard.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        self.presentViewController(vc, animated: true, completion: nil)
        NSLog("Back to login page")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}