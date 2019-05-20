//
//  HomeTableViewController.swift
//  StoreRestaurant
//
//  Created by Habib Akbari on 10/4/17.
//  Copyright © 2017 HabibMacBook Pro. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseDatabase

extension UINavigationBar {
    
    func transparentNavigationBar() {
    self.setBackgroundImage(UIImage(), for: .default)

        self.backgroundColor = UIColor(red: 14/255, green: 7/255, blue: 10/255, alpha: 0.4)
        
       guard  let statusBar = (UIApplication.shared.value(forKey: "statusBarWindow") as AnyObject).value(forKey: "statusBar") as? UIView else {
            return
        }
        statusBar.backgroundColor = UIColor(red: 14/255, green: 7/255, blue: 10/255, alpha: 0.4)
        
    }
}

class HomeTableViewController: UITableViewController, CLLocationManagerDelegate {

    //MARK: - IBOUTLET WEAK VAR
    @IBOutlet var homeTableView: UITableView!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var maximRestaurantImage: UIView!
    
    //MARK: - VAR
    var mapTaggle = false
    

    //MARK: - OVERRIDE FUNC
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.transparentNavigationBar()
        homeTableView.contentInset = UIEdgeInsetsMake(-88, 0, 0, 0)
        
        // set image background Table View Static
        let backgroundImage = UIImage(named: "background_classic_Home_black.png")
        let imageView = UIImageView(image: backgroundImage)
        homeTableView.backgroundView = imageView
        

        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        tableView.backgroundColor = UIColor.black
        
    }

    // change color back ground tableView Static
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let header = UIView()
        // change Header background Color tableView Static
        header.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
        
        let headerLabel = UILabel(frame: CGRect(x: 15, y: 10, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        // change font size color header tableView Static
        headerLabel.font = UIFont(name: "Verdana", size: 12.0)
        headerLabel.textColor = UIColor(red: 109/255, green: 109/255, blue: 109/255, alpha: 1.0)
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
    
        header.addSubview(headerLabel)
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        switch section {
            
        case 1:
            return "ABOUT US"
        case 2:
            return "OUR LOCATION"
        case 3:
            return "OUR PHOTOS"
        case 4:
            return "SOCIAL MEDIA"

        default:
            return ""
        }

    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section != 0 {
            
            return 40.0
            
        } else {
            
        return 0.0
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 2 && indexPath.row == 0 {
            
            toggleMap()
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if !mapTaggle && indexPath.section == 2 && indexPath.row == 1 {
            
            return 0
            
        } else {
            
            return super.tableView(tableView, heightForRowAt: indexPath)
            
        }
        
    }
    

    //MARK: - FUNC
    func loctionInMap() {
        
        let pinLocation = CLLocationCoordinate2D(latitude: 35.6997795542397, longitude: 51.3379191807295)
        let objectAnn = MKPointAnnotation()
        objectAnn.coordinate = pinLocation
        objectAnn.title = "Tehran"
        objectAnn.subtitle = "Tehran"
        self.mapView.addAnnotation(objectAnn)
        
        mapView.mapType = MKMapType.standard
        
        let span = MKCoordinateSpanMake(0.005, 0.005)
        let region = MKCoordinateRegion(center: pinLocation, span: span)
        
        mapView.setRegion(region, animated: true)
        
    }
    
    func toggleMap () {
        
        mapTaggle = !mapTaggle
        loctionInMap()
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    
    
}
