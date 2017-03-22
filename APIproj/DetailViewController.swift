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
    
    public var detailInfo = NSDictionary()
    var identifier : intptr_t = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (identifier == 0)
        {
            nameLabel.text = detailInfo.value(forKey: "artistName") as! String
            DownloaderImage.sharedInstance.retrieveImage(for: detailInfo.value(forKey: "artworkUrl100") as! String) {
                image in
                self.avatarView.image = image
            }
        }
        else
        {
            nameLabel.text = detailInfo.value(forKey: "login") as! String
            DownloaderImage.sharedInstance.retrieveImage(for: detailInfo.value(forKey: "avatar_url") as! String) {
                image in
                self.avatarView.image = image
            }
            
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
