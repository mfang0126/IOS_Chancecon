//
//  AboutViewController.swift
//  Chancecon
//
//  Created by Freedom on 18/06/16.
//  Copyright © 2016 Chancellor Construction Ltd. All rights reserved.
//

import UIKit
import MapKit

class AboutViewController: UIViewController{
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func MenuButtonTapped(sender: AnyObject) {
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Map
        let location = CLLocationCoordinate2D(latitude: -36.9522713, longitude: 174.8978722)
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        //Add Map Annotation
        let annotation = MKPointAnnotation()
        annotation.title = "CHANCELLOR CONSTRUCTION LTD"
        annotation.subtitle = "Unit 1-15 Accent Drive, East Tamaki"
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
        
        //Navigation Customization
        navigationController!.navigationBar.barStyle = .Black


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
