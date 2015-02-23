//
//  Status.swift
//  Tweetyness
//
//  Created by Ashar Rizqi on 2/21/15.
//  Copyright (c) 2015 Ashar Rizqi. All rights reserved.
//

import Foundation
import UIKit

class Status: NSObject {
    
    var user: User
    var text: String
    var createdAt: NSDate
    var numberOfRetweets: Int
    var numberOfFavorites: Int
    var mediaUrl: NSURL!
    var entities: NSDictionary!
    var favorited: Bool!
    var id: Int
    
    init(dictionary: NSDictionary) {
        self.user = User(dictionary: dictionary["user"] as NSDictionary)
        self.text = dictionary["text"] as String
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        self.createdAt = formatter.dateFromString(dictionary["created_at"] as String)!
        
        self.numberOfRetweets = dictionary["retweet_count"] as Int
        self.numberOfFavorites = dictionary["favorite_count"] as Int
        self.entities = dictionary["entities"] as NSDictionary
        var fav = dictionary["favorited"] as Int
        if fav == 1 {
            self.favorited = true
        }
        else {
            self.favorited = false
        }
        self.id = dictionary["id"] as Int
        
    }
    
    class func statusesWithArray(array: [NSDictionary]) -> [Status] {
        var statuses = [Status]()
        for dictionary in array {
            statuses.append(Status(dictionary: dictionary))
        }
        return statuses
    }
}
