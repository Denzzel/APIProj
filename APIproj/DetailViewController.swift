//
//  DetailViewController.swift
//  APIproj
//
//  Created by Admin on 21.03.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarView: UIImageView!
    
    var user : User = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = user.userData?.userName
        DownloaderImage.sharedInstance.retrieveImage(for: (user.userData?.userImageStr)!) {
            image in
            self.avatarView.image = image
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
