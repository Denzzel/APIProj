//
//  ViewController.swift
//  APIproj
//
//  Created by Admin on 09.03.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var arrRes = NSArray()
    
    @IBAction func SearchOK(_ sender: Any) {
        let searchString:String = "https://api.github.com/search/users?q=" + searchBar.text!
        
        downloadJSON(searchString: searchString)
    }
  
    
    func retrieveImage(for url: String, completion: @escaping (UIImage) -> Void) -> Request {
        return Alamofire.request(url, method: .get).responseImage { response in
            guard let image = response.result.value else { return }
            completion(image)
        }
    }
    
    
    func downloadJSON(searchString : String)
    {
        Alamofire.request(searchString).responseJSON() {
            (response) in
            let json = response.result.value! as? NSDictionary
            let items = (json?.value(forKey: "items") as? NSArray)
            self.arrRes = items!
            
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
        
        retrieveImage(for: item?.value(forKey: "avatar_url") as! String) {
            image in
                cell.imageView?.image = image
        }
        
        return cell
    }
 
}
