//
//  ComposeViewController.swift
//  Tweetyness
//
//  Created by Ashar Rizqi on 2/21/15.
//  Copyright (c) 2015 Ashar Rizqi. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var characterCountLabel: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileImage.layer.cornerRadius = 9.0
        self.profileImage.layer.masksToBounds = true
        self.profileImage.setImageWithURL(User.currentUser?.profileImageUrl)
        self.name.text = User.currentUser?.name
        self.handleLabel.text = "@\(User.currentUser!.screenname)"
//        self.textView.text = "Tweet something..."
        super.viewDidLoad()
        self.textView.text = ""
        self.characterCountLabel.text = "140"
        self.textView.becomeFirstResponder()
        
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
//        self.navigationController?.navigationBar.
        
        
        var backButton:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        backButton.addTarget(self, action: "onTweet", forControlEvents: UIControlEvents.TouchUpInside)
        backButton.setTitle("Tweet", forState: UIControlState.Normal)
        backButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        backButton.sizeToFit()
        var customBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.rightBarButtonItem  = customBackButtonItem
        
        self.textView.textColor = UIColor.lightGrayColor()
        
//        var cancelButton:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
//        cancelButton.setTitle("Cancel", forState: UIControlState.Normal)
//        cancelButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        cancelButton.sizeToFit()
//        var cancel:UIBarButtonItem = UIBarButtonItem(customView: cancelButton)
//        self.navigationItem.leftBarButtonItem  = cancel
        
//        var attributes = [NSForegroundColorAttributeName: UIColor.greenColor(),NSFontAttributeName: UIFont(name: "Avenir", size: 30)]
//        self.navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        var start = 140
        
        var newLength = start - countElements(text) - countElements(textView.text) + range.length
        
        if (newLength < 0){
            return false
        }
        self.characterCountLabel.text = "\(newLength)"
        return true
    }
    
    func onTweet(){
        var tweet = self.textView.text
        if (countElements(tweet) == 0) {
            return
        }
        var params:NSDictionary = ["status": tweet]
        TwitterClient.sharedInstance.postStatusUpdateWithParams(params, completion: { (status, error) -> () in
            if error != nil {
                println("there was an error: \(error)")
            }
            else {
                NSNotificationCenter.defaultCenter().postNotificationName("StatusPosted", object: status)
                self.navigationController?.popViewControllerAnimated(true)

            }
        })
    }
    

}
