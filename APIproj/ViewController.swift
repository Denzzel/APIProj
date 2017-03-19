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
            DownloaderJSON.downloadJSON(searchString: searchString, ItemKey: "results") {
                items in
                self.arrRes = items
                self.tableView.reloadData()
            }
            
        }
        else
        {
            let searchString:String = "https://api.github.com/search/users?q=" + searchBar.text!
            DownloaderJSON.downloadJSON(searchString: searchString, ItemKey: "items") {
                items in
                self.arrRes = items
                self.tableView.reloadData()
            }
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
            DownloaderImage.retrieveImage(for: item?.value(forKey: "artworkUrl100") as! String) {
                image in
                cell.imageView?.image = image
            }
        }
        else
        {
            cell.textLabel?.text = item?.value(forKey: "login") as! String
            DownloaderImage.retrieveImage(for: item?.value(forKey: "avatar_url") as! String) {
                image in
                cell.imageView?.image = image
            }
        }
        
        
        return cell
    }
    
}
