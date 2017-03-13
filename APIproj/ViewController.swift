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

class ViewController: UIViewController {

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
            for item in items!
            //let item = items?[0] as? NSDictionary
            {
                let tmp = item as? NSDictionary
                print(tmp?.value(forKey: "login") as! NSString)
                print(tmp?.value(forKey: "avatar_url") as! NSString)
                self.arrRes.adding(tmp!)
                var cell : UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
                if cell==nil {
                    //cell = UITableViewCell(style: UITableViewStyle, reuseIdentifier: "cell")
                }
                cell.textLabel?.text = (tmp?.value(forKey: "login") as! String)
                
                self.tableView.reloadData()
                
            }
        }
    }
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
     //   return arrRes.count
    //}
    
    
    //override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
      //  let identifier = "cell"
      //  var cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier)! as UITableViewCell
      //  if cell==nil {
      //      cell.textLabel?.text = (arrRes[indexPath!.row] as! NSDictionary).value(forKey: "login") as! String
    //    }
        

    //    return cell
  //  }

}

