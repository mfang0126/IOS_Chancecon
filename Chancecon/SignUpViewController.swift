//
//  SignUpViewController.swift
//  Chancecon
//
//  Created by Freedom on 18/06/16.
//  Copyright © 2016 Chancellor Construction Ltd. All rights reserved.
//

import UIKit
import Firebase
class SignUpViewController: UIViewController {
    
    @IBOutlet weak var userEmailAddressTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var userPasswordRepeatTextField: UITextField!
    
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func SignUpButtonTapped(sender: AnyObject) {
        let userEmail = userEmailAddressTextField.text
        let userPassword = userPasswordTextField.text
        let userPasswordRepeat = userPasswordRepeatTextField.text
        
        if( userPassword != userPasswordRepeat)
        {
            // Display alert message
            displayAlertMessage("Passwords do not match")
            return
        }
        
        if(userEmail!.isEmpty || userPassword!.isEmpty)
        {
            // Display an alert message
            displayAlertMessage("All fields are required to fill in")
            return
        }
        
        let spinningActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        spinningActivity.labelText = "Loading"
        spinningActivity.detailsLabelText = "Please wait"
        
        FIRAuth.auth()?.createUserWithEmail(self.userEmailAddressTextField.text!, password: self.userPasswordTextField.text!, completion: { (user, error) in
            if error != nil {
                let myAlert = UIAlertController(title: "Alert", message:"Internet Connection Error.", preferredStyle: UIAlertControllerStyle.Alert);
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:nil)
                myAlert.addAction(okAction)
                self.presentViewController(myAlert, animated: true, completion: nil)
                
            } else {
                print("Loged in")
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                
                appDelegate.buildNavigationDrawer()
            }
        })

        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.barStyle = .Black

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    func displayAlertMessage(userMessage:String)
    {
        let myAlert = UIAlertController(title: "Alert", message:userMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:nil)
        
        myAlert.addAction(okAction);
        
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }
    
}
