//
//  TwitterClient.swift
//  TwitterClient
//
//  Created by Sean Nam on 2/28/17.
//  Copyright © 2017 Sean Nam. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "ToAJ5WTnje0AFjUBUfP8sKZX0", consumerSecret: "DCisUh5dIlJuijszdXXgozvTNBClOzVV7mwhfu8IlhXN2Ac21L")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
            
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
            //UIApplication.shared.openURL((url)!)
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
            
        }) { (error:Error?) -> Void in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        }
    }
    func handleOpenUrl(url: URL) {
        
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken:BDBOAuth1Credential?) -> Void in
            print("I got the access token")
            
            self.loginSuccess?()
            /*
            client?.homeTimeLine(success: { (tweets: [Tweet]) -> () in
                for tweet in tweets {
                    print(tweet.text!)
                }
            }) {(error:Error) -> () in
                print(error.localizedDescription)
            }
            client?.currentAccount()
            */
        }) { (error:Error?) ->Void in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        }
    }
    func currentAccount() {
        get("1.1/account/verify_credentials.json", parameters:nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            //print("account: \(response)")
            
            let userDictionary = response as! NSDictionary
            
            let user = User(dictionary: userDictionary)
            /*
            print("name: \(user.name)")
            print("screename: \(user.screenname)")
            print("profile url: \(user.profileUrl)")
            print("description: \(user.tagline)")
            */
            
        }) { (task: URLSessionDataTask?, error: Error) -> Void in
            
        }
    }
    
    func homeTimeLine(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        
        get("1.1/statuses/home_timeline.json", parameters:nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            print("account: \(response)")
            
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
            
            print("[DEBUG] \(tweets)")
//            for tweet in tweets {
//                print("\(tweet.text)!")
//            }
            
            
        }) { (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error)
        }
    }
}
