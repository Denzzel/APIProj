//
//  myTableViewController.swift
//  APIproj
//
//  Created by Admin on 21.03.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class myTableViewController: UITableViewController {

    var arrRes = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrRes.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
