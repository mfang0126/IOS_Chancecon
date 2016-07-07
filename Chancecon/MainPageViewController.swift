//
//  MainPageViewController.swift
//  Chancecon
//
//  Created by Freedom on 18/06/16.
//  Copyright © 2016 Chancellor Construction Ltd. All rights reserved.
//

import UIKit
import CircleProgressBar
import FirebaseDatabase
import FirebaseAuth


class MainPageViewController: UIViewController {
    
    var ref:FIRDatabaseReference!
    
    @IBOutlet weak var progressBarOut: CircleProgressBar!
    @IBOutlet weak var progressBarIn: CircleProgressBar!
    @IBOutlet weak var percentageOut: UILabel!
    @IBOutlet weak var percentageIn: UILabel!
    @IBOutlet weak var dashboardDescription: UITextView!

    
    
    @IBAction func MenuButtonTapped(sender: AnyObject) {
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    
    @IBAction func testButton(sender: AnyObject) {
        getInstanceValue()
    }
    
    override func viewDidAppear(animated: Bool) {
        getInstanceValue()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Firebase
        self.ref = FIRDatabase.database().reference()
        getInstanceValue()
        
        //Navigation Bar
        navigationController!.navigationBar.barStyle = .Black

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getInstanceValue() {
        //get user Id
        let uid = FIRAuth.auth()?.currentUser?.uid
        //retrieve data from Firebase
        FIRDatabase.database().reference().child("users").child(uid!).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
//            print(snapshot)
            self.dashboardDescription.text = snapshot.value!["description"] as! String
//            print(self.dashboardDescription.text)
            
            self.dashboardDescription.font = UIFont (name: "Helvetica Neue", size: 15)
            self.percentageIn.text = snapshot.value!["percentageIn"] as? String
//            print(self.percentageIn.text)
            
            self.percentageOut.text = snapshot.value!["percentageOut"] as? String
//            print(self.percentageOut.text)
            
            let inNumber = snapshot.value!["progressIn"] as! CGFloat
            self.progressBarIn.setProgress(inNumber, animated: true)
//            print(inNumber)
            
            let outNumber = snapshot.value!["progressOut"] as! CGFloat
            self.progressBarOut.setProgress(outNumber, animated: true)
//            print(outNumber)
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }

}

