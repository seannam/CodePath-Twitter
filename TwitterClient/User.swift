//
//  User.swift
//  TwitterClient
//
//  Created by Sean Nam on 2/28/17.
//  Copyright © 2017 Sean Nam. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: String?
    var screenname: String?
    var profileUrl: URL?
    var backgroundUrl: URL?
    var tagline: String?
    
    var tweetsCount: Int?
    var followersCount: Int?
    var friendsCount: Int?
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary

        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
        
        let backgroundUrlString = dictionary["profile_background_image_url_https"] as? String
        if let backgroundUrlString = backgroundUrlString {
            backgroundUrl = URL(string: backgroundUrlString)
        }
        
        tagline = dictionary["description"] as? String
        
        tweetsCount = dictionary["statuses_count"] as? Int
        followersCount = dictionary["followers_count"] as? Int
        friendsCount = dictionary["friends_count"] as? Int
    }
    
    static let userDidLogoutNotification = "UserDidLogout"

    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                if _currentUser == nil {
                    let defaults = UserDefaults.standard
                    
                    let userData = defaults.object(forKey: "currentUserData") as? NSData
                    
                    if let userData = userData {
                        let dictionary = try! JSONSerialization.jsonObject(with: userData as Data, options: [])
                        _currentUser = User(dictionary: dictionary as! NSDictionary)
                    }
                }
            }
                return _currentUser
            
        }
        
        set(user) {
            _currentUser = user
            let defaults = UserDefaults.standard
            
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
            defaults.synchronize()
            
        }
    }
    
}
