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
        //Ad links
        UIApplication.sharedApplication().openURL(NSURL(string: "Http://chancecon.co.nz")!)
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}