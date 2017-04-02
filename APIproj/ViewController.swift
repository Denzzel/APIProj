//
//  ViewController.swift
//  APIproj
//
//  Created by Admin on 09.03.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
//import RealmSwift

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var arrUsers : [User] = []
    var cellIndex : intptr_t = 0
    
    @IBAction func SearchOK(_ sender: Any) {
       // let realm = try! Realm()
        var us : User = User()
        if (Connection.sharedInstance.isInternetAvailable()) {
            if (segmentedControl.selectedSegmentIndex == 0)
            {
                DataService.sharedInstance.getItunesUsersFromJSON(querry: searchBar.text!) {
                    users in
                    self.arrUsers = users
                    DBservice.sharedInstance.crearDB()
                    DBservice.sharedInstance.writeArrayOfUsers(users: users)
                    self.tableView.reloadData()
                }
            }
            else
            {
                DataService.sharedInstance.getGitUsersFromJSON(querry: searchBar.text!) {
                    users in
                    self.arrUsers = users
                    DBservice.sharedInstance.crearDB()
                    DBservice.sharedInstance.writeArrayOfUsers(users: users)
                    self.tableView.reloadData()
                }
            }
        }
        else {
            arrUsers = DBservice.sharedInstance.getCashedUsers()
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
        return self.arrUsers.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        var user = self.arrUsers[indexPath.row]

        cell.textLabel?.text = user.userData!.userName
        DownloaderImage.sharedInstance.retrieveImage(for: user.userData!.userImageStr!) {
            image in
            cell.imageView?.image = image
        }
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  (segue.identifier == "ShowDetails")
        {
            let destination = segue.destination as? DetailViewController
            destination?.user = arrUsers[cellIndex]
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.cellIndex = indexPath.row
        performSegue(withIdentifier: "ShowDetails", sender: Any?.self)
    }
    
}
