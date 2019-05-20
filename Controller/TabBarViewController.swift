//
//  TabBarViewController.swift
//  StoreRestaurant
//
//  Created by Habib Akbari on 5/24/18.
//  Copyright © 2018 HabibMacBook Pro. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    //MARK: - IBOUTLET WEAK VAR
    @IBOutlet weak var tabBarView: UITabBar!
  
    
    //MARK: - OVERRIDE FUNC
    override func viewDidLoad() {
        
        super.viewDidLoad()

        moreNavigationController.navigationBar.transparentNavigationBar()

    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        let indexOfTab = tabBarView.items?.index(of: item)
        
        if indexOfTab! == 4 {
            
            let navigationBar = UINavigationBar.appearance()
            navigationBar.barTintColor = UIColor(red: 35/256, green: 39/256, blue: 50/256, alpha: 0.5)

            // Change Color MoreNavigtionTitle
            navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            moreNavigationController.view.tintColor = UIColor.green
            self.view.tintColor = UIColor.green
            
            self.tabBarBack()
            self.more()
            
        }
        
    }
    
    
    //MARK: - FUNC
    func more() {
        
        let moreNavController = self.moreNavigationController

        if let moreTableView = moreNavController.topViewController?.view as? UITableView {
            
            for cell in moreTableView.visibleCells {
                cell.textLabel?.textColor = UIColor.white
                cell.backgroundColor = UIColor(red: 56/256, green: 58/256, blue: 58/256, alpha: 0.5)
            }
        }
        
    }
    
    func tabBarBack() {

        
        let moreTableView = moreNavigationController.topViewController?.view as? UITableView
        if moreTableView is UITableView {
            
            // set image background Table View Static
            let backgroundImage = UIImage(named: "background_classic_Home_black.png")
            let imageView = UIImageView(image: backgroundImage)

            //moreTableView?.backgroundColor = UIColor.red
            moreTableView?.backgroundView  = imageView
            moreTableView?.separatorStyle = .none
            moreTableView?.tintColor = UIColor.white
            
            
          }
        
        }
    
    
    }
    

