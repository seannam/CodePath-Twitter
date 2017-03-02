//
//  Tweet.swift
//  TwitterClient
//
//  Created by Sean Nam on 2/28/17.
//  Copyright © 2017 Sean Nam. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var user: User?
    
    var text: String?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    
    var retweeted: Bool
    var favourited: Bool
    
    var id: Int
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        
        text = dictionary["text"] as? String
        
        retweeted = dictionary["retweeted"] as! Bool
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0

        favourited = dictionary["favorited"] as! Bool
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        id = dictionary["id"] as! Int
        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString)
        }
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }
}
