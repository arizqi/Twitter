//
//  ProfileViewController.swift
//  Tweetyness
//
//  Created by Ashar Rizqi on 2/28/15.
//  Copyright (c) 2015 Ashar Rizqi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tweetCountLabel: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var followingCountLabel: UILabel!
    
    @IBOutlet weak var followersCountLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var handleLabel: UILabel!
    
    var statuses: [Status]?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "profile")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
//        self.imgCont.backgroundColor = UIColor(patternImage:
        
        
        var panGesture = UIPanGestureRecognizer()
        panGesture.addTarget(self, action: "onPan:")
        self.backgroundImage.addGestureRecognizer(panGesture)
        
        self.profileImage.layer.cornerRadius = 9.0
        self.profileImage.layer.masksToBounds = true
        self.profileImage.setImageWithURL(user?.profileImageUrl)
//        self.profileImage.layer.cornerRadius = 9.0
        self.tweetCountLabel.text = "\(user?.tweetCount as Int!)"
        self.followersCountLabel.text = "\(user?.followersCount as Int!)"
        self.followingCountLabel.text = "\(user?.followingCount as Int!)"
        self.usernameLabel.text = user?.name
        self.handleLabel.text = "@\(user?.screenname as String!)"
        println(user?.profileBackgroundImageUrl)
        self.backgroundImage.setImageWithURL(user?.profileBackgroundImageUrl)
//        self.backgroundImage.alpha = 0.6
        
        var requestParams = ["screen_name":user?.screenname as String!, "count": "20"]
        
        TwitterClient.sharedInstance.userTimelineWithParams(requestParams, completion: { (statuses, error) -> () in
            
            self.statuses = statuses
            println(statuses)
            self.tableView.reloadData()
        })
        
//        self.tweetCountLabel.text = User.currentUs3er?.

        // Do any additional setup after loading the view.
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
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("tweetCell2") as TweetCell
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
    
    func onPan(panGestureRecognizer: UIPanGestureRecognizer) {
        
        var point = panGestureRecognizer.locationInView(view)
        var velocity = panGestureRecognizer.velocityInView(view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            UIView.animateWithDuration(0.35, animations: {
                
                panGestureRecognizer.view!.transform = CGAffineTransformMakeScale(1.25, 0.75)
                
                }, completion: { (finished) in
                    NSLog("Animation completed.")
            })
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            println("Gesture changed at: \(point)")
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            println("Gesture ended at: \(point)")
            panGestureRecognizer.view?.transform = CGAffineTransformMakeScale(1, 1)
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
