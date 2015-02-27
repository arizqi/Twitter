//
//  TweetDetailViewController.swift
//  Tweetyness
//
//  Created by Ashar Rizqi on 2/21/15.
//  Copyright (c) 2015 Ashar Rizqi. All rights reserved.
//

import UIKit


class TweetDetailViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    @IBOutlet weak var tweetImage: UIImageView!
    var status: Status?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(self.status)
        
        self.navigationItem.title = "Tweet"
        
        self.profileImage.setImageWithURL(self.status?.user.profileImageUrl)
        self.profileImage.layer.cornerRadius = 9.0
        self.profileImage.layer.masksToBounds = true
        self.nameLabel.text = self.status?.user.name
        self.handleLabel.text = "@\(self.status!.user.screenname)"
        self.tweetLabel.text = self.status?.text
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy 'at' h:mm aaa"
        self.dateLabel.text = formatter.stringFromDate(self.status!.createdAt)
        
        self.retweetCountLabel.text = "\(self.status!.numberOfRetweets)"
        self.favoriteCountLabel.text = "\(self.status!.numberOfFavorites)"
        var media = []
        if self.status?.entities?["media"] != nil {
            println("media exists")
            media = self.status?.entities?["media"] as NSArray
            var media_dict = media[0] as NSDictionary
            var media_url = media_dict["media_url"]? as String
            var base_url = NSURL(string: media_url)
//            println(media_url)
            self.tweetImage.setImageWithURL(base_url)
        }
    }

}
