//
//  DetailsNewsViewController.swift
//  StoreRestaurant
//
//  Created by Habib Akbari on 10/8/17.
//  Copyright © 2017 HabibMacBook Pro. All rights reserved.
//

import UIKit

extension UINavigationItem {
    
    func addSettingButtonLeft() {
        
        let button = UIButton(type: .custom)
        button.setTitle("Close", for: .normal)
        button.backgroundColor = UIColor(red: 78/256, green: 161/256, blue: 206/256, alpha: 1.0)
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 2
        button.frame = CGRect(x: 0, y: 0, width: 70, height: 60)
        button.addTarget(self, action: #selector(DetailsNewsViewController.done), for: UIControlEvents.touchUpInside)
        
        let barButton = UIBarButtonItem(customView: button)
        self.leftBarButtonItem = barButton
        
    }
    
}

class DetailsNewsViewController: UIViewController {
    
    //MARK: - IBOUTLET WEAK VAR
    @IBOutlet var detailsNewsImage: UIImageView!
    @IBOutlet var detailsTitleNewsLabel: UILabel!
    @IBOutlet var detailsTimeLabel: UILabel!
    @IBOutlet var detailsNewsTextView: UITextView!
    @IBOutlet var scroller: UIScrollView!
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var blurView: UIView!
    
    
    //MARK: - VAR
    var detsilsNews : AnyObject {
        get {
            return UserDefaults.standard.object(forKey: "detsilsNews") as AnyObject
        }
    }
    var detailsArray = [AnyObject]()
    
    
    //MARK: - OVERRIDE FUNC
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //transparentNavigtionBar()
        transparentNavigtionBar()
        scroller.contentInset = UIEdgeInsetsMake(0, 0, 400, 0)

        updateData()

        // Navigtion Bar Hidden On

        self.navigationController?.setNavigationBarHidden(true, animated: true)

        closeButtonUI()

    }

    override func viewWillLayoutSubviews() {
        
        self.scroller.frame = self.view.bounds
        self.scroller.contentSize.height = 400
        self.scroller.contentSize.width = 0
        
    }
    
    
    //MARK: - FUNC
    func closeButtonUI() {
        
        closeButton.layer.cornerRadius = 10
        closeButton.layer.shadowColor = UIColor.black.cgColor
        closeButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        closeButton.layer.shadowRadius = 2
        
    }
    
    func updateData() {
        
        detailsTitleNewsLabel.text = detsilsNews["title"] as! String
        detailsTimeLabel.text = detsilsNews["date"] as! String
        
        let url = NSURL(string: "\(detsilsNews["image"] as! String)")!
        let data = NSData(contentsOf: url as URL)
        detailsNewsImage.image = UIImage(data: data as! Data)
        
        detailsNewsTextView.text = detsilsNews["news"] as! String

    }

    func transparentNavigtionBar() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.isTranslucent = true
      
    }
    
    func addSettingButtonLeft() {
        
        let button = UIButton(type: .custom)
        button.setTitle("Close", for: .normal)
        button.backgroundColor = UIColor(red: 78/256, green: 161/256, blue: 206/256, alpha: 1.0)
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 2
        button.frame = CGRect(x: 0, y: 0, width: 70, height: 40)
        button.addTarget(self, action: #selector(done), for: UIControlEvents.touchUpInside)
        
        let barButton = UIBarButtonItem(customView: button)
        
        navigationItem.leftBarButtonItem = barButton
        
    }
    

    
    
    //MARK: - OBJC FUNC
    @objc func done() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        let _ = self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    
    //MARK: - IBACTION FUNC
    @IBAction func close(_ sender: Any) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        let _ = self.navigationController?.popToRootViewController(animated: true)
        
    }
    
}
