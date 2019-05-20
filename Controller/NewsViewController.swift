//
//  NewsViewController.swift
//  StoreRestaurant
//
//  Created by Habib Akbari on 10/6/17.
//  Copyright © 2017 HabibMacBook Pro. All rights reserved.
//

import UIKit
import FirebaseDatabase

class NewsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    //MARK: - IBOUTLET WEAK VAR
    @IBOutlet weak var newsTableView: UITableView!
    
    
    //MARK: - VAR
    var detailsNews : AnyObject {
        
        get {
            return UserDefaults.standard.object(forKey: "detsilsNews") as AnyObject
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "detsilsNews")
            UserDefaults.standard.synchronize()
        }
    }
    var databaseReference : FIRDatabaseReference?
    var dictionaryNews = [String:AnyObject]()
    var arrayNews = [[String:AnyObject]]()

    
    //MARK: - OVERRIDE FUNC
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.navigationController?.navigationBar.transparentNavigationBar()
    
        loadDataFirbase()
        
    }
    
    
    //MARK: - FUNC
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayNews.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellNews", for: indexPath) as! NewsTableViewCell
        cell.configCell(newsRow: arrayNews[indexPath.row] )

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        detailsNews = arrayNews[indexPath.row] as AnyObject
        
    }
    
    func transparentNavigtionBar() {

        UINavigationBar.appearance().backgroundColor = UIColor.green
        
    }

    func loadDataFirbase() {
        
        if dictionaryNews.isEmpty {
            
            databaseReference = FIRDatabase.database().reference()
            databaseReference?.child("news").observeSingleEvent(of: .value, with: { (snapshot) in
                
                self.dictionaryNews = snapshot.value as! [String:AnyObject]

                for news in self.dictionaryNews {

                    let valueNews = news.value
                    
                    self.arrayNews.append(valueNews as! [String : AnyObject])
                    self.newsTableView.reloadData()

                }

            })
            
        }
    }

}
