//
//  NewsViewController.swift
//  Chancecon
//
//  Created by Freedom on 22/06/16.
//  Copyright © 2016 Chancellor Construction Ltd. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var newsWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.barStyle = .Black

        let spinningActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        spinningActivity.labelText = "Loading"
        spinningActivity.detailsLabelText = "Please wait"
        
        let url = NSURL(string: "http://chancecon.co.nz/news/")
        let request = NSURLRequest(URL: url!)
        newsWebView.loadRequest(request)
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
