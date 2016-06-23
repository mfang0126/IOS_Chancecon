//
//  ViewController.swift
//  Chancecon
//
//  Created by Freedom on 17/06/16.
//  Copyright © 2016 Chancellor Construction Ltd. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func SignInTapped(sender: AnyObject) {
        let userEmailAddress = Username.text
        let userPassword = Password.text
        
        if(userEmailAddress!.isEmpty || userPassword!.isEmpty)
        {
            // Display an alert message
            let myAlert = UIAlertController(title: "Alert", message:"All fields are required to fill in", preferredStyle: UIAlertControllerStyle.Alert);
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:nil)
            myAlert.addAction(okAction)
            self.presentViewController(myAlert, animated: true, completion: nil)
            return
        }
        
        let spinningActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        spinningActivity.labelText = "Loading"
        spinningActivity.detailsLabelText = "Please wait"
        
        FIRAuth.auth()?.signInWithEmail(Username.text!, password: Password.text!, completion: {
            user, error in
            
            if error != nil {
                print("Incorrect")
                let myAlert = UIAlertController(title: "Alert", message:"Your username or password is incorrect.", preferredStyle: UIAlertControllerStyle.Alert);
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:nil)
                myAlert.addAction(okAction)
                self.presentViewController(myAlert, animated: true, completion: nil)
                spinningActivity.hide(true)
                
            } else {
                print("Loged in ")
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                
                appDelegate.buildNavigationDrawer()
            }
        })
        
    }
    
    
}

