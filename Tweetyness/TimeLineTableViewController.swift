//
//  TimeLineTableViewController.swift
//  Tweetyness
//
//  Created by Ashar Rizqi on 2/21/15.
//  Copyright (c) 2015 Ashar Rizqi. All rights reserved.
//

import UIKit

@objc
protocol TimeLineTableViewControllerDelegate  {
    optional func toggleLeftPanel()
    optional func toggleRightPanel()
    optional func collapseSidePanels()
}

class TimeLineTableViewController: UITableViewController, SidePanelViewControllerDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var navItem: UINavigationItem!
    var statuses: [Status]?
    var refresh: UIRefreshControl!
    var delegate: TimeLineTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var titleLabel = UILabel()
        titleLabel.textColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.topItem?.title = "Home"
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.insertSubview(refresh, atIndex: 0)
        let logo = UIImage(named: "home")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        self.navigationController?.navigationBar.barTintColor = TwitterColor().twitterBlue
        
        NSNotificationCenter.defaultCenter().addObserverForName("StatusPosted", object: nil, queue: nil) { (notification: NSNotification!) -> Void in
            let status = notification.object as Status
            self.statuses?.insert(status, atIndex: 0)
            self.tableView.reloadData()
        }
        
        //buttons
        var logOutButton:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        logOutButton.addTarget(self, action: "onLogout", forControlEvents: UIControlEvents.TouchUpInside)
        logOutButton.setTitle("Logout", forState: UIControlState.Normal)
        logOutButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        logOutButton.sizeToFit()
        var customBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: logOutButton)
        self.navigationItem.leftBarButtonItem  = customBackButtonItem
        
        var newButton:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        newButton.addTarget(self, action: "newPressed", forControlEvents: UIControlEvents.TouchUpInside)
        newButton.setTitle("New", forState: UIControlState.Normal)
        newButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        newButton.sizeToFit()
        var customForwardButtonItem:UIBarButtonItem = UIBarButtonItem(customView: newButton)
        self.navigationItem.rightBarButtonItem  = customForwardButtonItem
        
        self.loadStatuses()
    }
    
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func onRefresh() {
        delay(1, closure: {
            TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (statuses, error) -> () in
                self.loadStatuses()
            })
            self.refresh.endRefreshing()
        })
    }
    
    
    func loadStatuses() {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (statuses, error) -> () in
            self.statuses = statuses
            self.tableView.reloadData()
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                return ()
            })
        })
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell") as TweetCell
        var tweet = self.statuses?[indexPath.row]
        cell.nameLabel.text = tweet?.user.name
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
        if tweet?.retweeted == true {
            var favoriteOn = UIImage(named: "retweet_on")
            cell.retweetButton.setImage(favoriteOn, forState: .Normal)
        }
        
        var tapRec = UITapGestureRecognizer()
        cell.profileImage.tag = indexPath.row
        tapRec.addTarget(self, action: "imageTapped:")
        cell.profileImage.addGestureRecognizer(tapRec)
        
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.statuses?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let tc = storyboard.instantiateViewControllerWithIdentifier("TweetDetailViewController") as TweetDetailViewController
        var tweet = self.statuses![indexPath.row]
        println(tweet.user.name)
        tc.status = self.statuses![indexPath.row]
        self.navigationController?.pushViewController(tc, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    func onLogout() {
        User.currentUser?.logout()
    }
    
    func newPressed(){
        self.performSegueWithIdentifier("composeSegue", sender: self)
    }
    
    func menuItemSelected(menuItem: MenuItem) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        switch menuItem.title  {
            case "Profile":
                let controller = storyboard.instantiateViewControllerWithIdentifier("ProfileViewController") as ProfileViewController
                controller.user = User.currentUser
                self.navigationController?.pushViewController(controller, animated: true)
            case "Home":
                let controller = storyboard.instantiateViewControllerWithIdentifier("TimeLineTableViewController") as TimeLineTableViewController
                self.navigationController?.pushViewController(controller, animated: true)
            case "Mentions":
                TwitterClient.sharedInstance.mentionsTimelineWithParams(nil, completion: { (statuses, error) -> () in
                    let controller = storyboard.instantiateViewControllerWithIdentifier("MentionsViewController") as MentionsViewController
                        controller.statuses = statuses
                    self.navigationController?.pushViewController(controller, animated: true)
                })
                
                println("mentions")
            default:
                println("none")
        }
        
        delegate?.collapseSidePanels?()
    }
    
    func imageTapped(sender: UITapGestureRecognizer){
        let tag = sender.view?.tag as Int!
        var tweet = self.statuses?[tag]
        var screenname = tweet?.user.screenname as String!
        var reqParams = ["screen_name":screenname] as NSDictionary
        println(screenname)
//        var reqParams = ["screen_name":screenname as NSString
//] as NSDictionary
        TwitterClient.sharedInstance.userLookupWithParams(reqParams, completion: { (user, error) -> () in
            let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let upvc = storyboard.instantiateViewControllerWithIdentifier("ProfileViewController") as ProfileViewController
            upvc.user = user!
            self.navigationController?.pushViewController(upvc, animated: true)
            println(user)
//            self.navigationController?.pushViewController(upvc, animated: true)
        })
    }
        

}
