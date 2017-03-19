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
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var arrRes = NSArray()
    
    @IBAction func SearchOK(_ sender: Any) {
        
        if (segmentedControl.selectedSegmentIndex == 0)
        {
            let searchString:String = "https://itunes.apple.com/search?term=" + searchBar.text!
            downloadJSONforItunes(searchString: searchString)
        }
        else
        {
            let searchString:String = "https://api.github.com/search/users?q=" + searchBar.text!
            downloadJSONforGit(searchString: searchString)
        }
    }
    
    
    func retrieveImage(for url: String, completion: @escaping (UIImage) -> Void) -> Request {
        return Alamofire.request(url, method: .get).responseImage { response in
            guard let image = response.result.value else { return }
            completion(image)
        }
    }
    
    func downloadJSONforItunes(searchString : String)
    {
        Alamofire.request(searchString).responseJSON() {
            (response) in
            print(response.result.value!)
            let json = response.result.value! as? NSDictionary
            let items = (json?.value(forKey: "results") as? NSArray)
            self.arrRes = items!
            
            self.tableView.reloadData()
            
        }
    }
    
    func downloadJSONforGit(searchString : String)
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
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrRes.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        var item = self.arrRes[indexPath.row] as? NSDictionary
        
        if (self.segmentedControl.selectedSegmentIndex == 0)
        {
            cell.textLabel?.text = item?.value(forKey: "artistName") as! String
            retrieveImage(for: item?.value(forKey: "artworkUrl100") as! String) {
                image in
                cell.imageView?.image = image
            }
            //https://is4.mzstatic.com/image/thumb/Music49/v4/95/37/48/95374800-15bb-ecae-e2f9-9f008dc743d0/source/100x100bb.jpg
        }
        else
        {
            cell.textLabel?.text = item?.value(forKey: "login") as! String
            retrieveImage(for: item?.value(forKey: "avatar_url") as! String) {
                image in
                cell.imageView?.image = image
            }
        }
        
        
        return cell
    }
    
}
