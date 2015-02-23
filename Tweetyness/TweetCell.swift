//
//  TweetCell.swift
//  Tweetyness
//
//  Created by Ashar Rizqi on 2/21/15.
//  Copyright (c) 2015 Ashar Rizqi. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    var tweetId:Int?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var tweetAgeLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!

    @IBOutlet weak var replyButton: UIButton!
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
//    @IBAction func onFavorite(sender: AnyObject) {
////        var params = Dictionary<String, Int>()
////        params["id"] = self.tweetId
//////        var params = ["id" : tweetId] as NSDictionary
////        TwitterClient.sharedInstance.postCreateFavoriteWithParams(params as NSDictionary) { (status, error) -> () in
////            if error == nil {
////                println("successfully favorited")
////                var favoriteOn = UIImage(named: "favorite_on")
////                self.favoriteButton.setImage(favoriteOn, forState: .Highlighted)
////            }
////            else {
////                println("there was an error favoriting the tweet")
////            }
////        }
//    }
    
//    @IBAction func onReTweet(sender: AnyObject) {
//    }
//    
//    @IBAction func onReply(sender: AnyObject) {
//    }
    
    
    
}
