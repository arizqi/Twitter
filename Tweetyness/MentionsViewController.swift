//
//  MentionsViewController.swift
//  Tweetyness
//
//  Created by Ashar Rizqi on 3/1/15.
//  Copyright (c) 2015 Ashar Rizqi. All rights reserved.
//

import UIKit

class MentionsViewController: UIViewController {

    var statuses: [Status]?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "mentions")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        println(self.statuses)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("returning number of rows")
        return self.statuses?.count ?? 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("tweetCell") as TweetCell
        var tweet = self.statuses?[indexPath.row]
        cell.nameLabel.text = tweet?.user.name
        println(tweet?.user.name)
        var handle = tweet!.user.screenname
        cell.handleLabel.text = "@\(handle)"
        cell.tweetLabel.text = tweet?.text
        cell.profileImage.layer.cornerRadius = 9.0
        cell.profileImage.layer.masksToBounds = true
        cell.profileImage.setImageWithURL(tweet!.user.profileImageUrl)
        cell.tweetAgeLabel.text = tweet?.createdAt.timeAgo()
        cell.tweetId = tweet?.id
        if tweet?.favorited == true {
            var favoriteOn = UIImage(named: "favorite_on")
            cell.favoriteButton.setImage(favoriteOn, forState: .Normal)
        }
        
        
        return cell
    }


}
