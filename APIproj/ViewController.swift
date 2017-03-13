//
//  ViewController.swift
//  APIproj
//
//  Created by Admin on 09.03.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var arrRes = NSArray()
    
    @IBAction func SearchOK(_ sender: Any) {
        var searchString:String = searchBar.text!
        searchString = "https://api.github.com/search/users?q=denis"
        Alamofire.request(searchString).responseJSON() {
            (response) in
            //print(response)
            let json = response.result.value! as? NSDictionary
            let items = (json?.value(forKey: "items") as? NSArray)
            self.arrRes = items!
            for item in items!
            //let item = items?[0] as? NSDictionary
            {
                let tmp = item as? NSDictionary
                print(tmp?.value(forKey: "login") as! NSString)
                print(tmp?.value(forKey: "avatar_url") as! NSString)
                //self.arrRes.adding(tmp!)
            }
            self.tableView.reloadData()
            
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrRes.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        var item = self.arrRes[indexPath.row] as? NSDictionary
        cell.textLabel?.text = item?.value(forKey: "login") as! String
        
        return cell
    }
 
}
