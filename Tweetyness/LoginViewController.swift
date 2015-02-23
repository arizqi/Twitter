//
//  LoginViewController.swift
//  Tweetyness
//
//  Created by Ashar Rizqi on 2/21/15.
//  Copyright (c) 2015 Ashar Rizqi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.loginButton.backgroundColor = UIColor.blackColor()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if user != nil {
                let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                let controller = storyboard.instantiateViewControllerWithIdentifier("TimeLineTableViewController") as TimeLineTableViewController
                self.navigationController?.pushViewController(controller, animated: true)
            } else {
                // Handle login error
            }
        }
    }
}

