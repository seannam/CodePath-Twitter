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
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }
    
    func handleOpenUrl(url: URL) {
        
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken:BDBOAuth1Credential?) -> Void in
            //print("I got the access token")
            
            self.currentAccount(success: { (user: User) in
                User.currentUser = user
                
                self.loginSuccess?()
            }, failure: { (error: Error) in
                self.loginFailure?(error)
            })
            self.loginSuccess?()
        }) { (error:Error?) ->Void in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        }
    }
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/account/verify_credentials.json", parameters:nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            //print("account: \(response)")
            
            let userDictionary = response as! NSDictionary
            
            let user = User(dictionary: userDictionary)
            
            success(user)
            
        }) { (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error)
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
    
    func retweet(id: Int, params: NSDictionary?, completion: @escaping (_ error: Error?) -> ()) {
        post("1.1/statuses/retweet/\(id).json", parameters: params, success: {(operation: URLSessionDataTask!, response: Any?) -> Void in
            print("[DEBUG] retweeting with ID \(id)")
            completion(nil)
        }, failure: { (operation: URLSessionDataTask?, error: Error!) -> Void in
            print("Error retweeting")
            completion(error as Error?)
        }
        )
    }
    
    func unretweet(id: Int, params: NSDictionary?, completion: @escaping (_ error: Error?) -> ()) {
        post("1.1/statuses/unretweet/\(id).json", parameters: params, success: { (operation: URLSessionDataTask!, response: Any?) -> Void in
            print("[DEBUG] unretweeting with ID \(id)")
            completion(nil)
        }, failure: { (operation: URLSessionDataTask?, error: Error?) -> Void in
            print("[DEBUG] Error unretweeting")
            completion(error as Error?)
        }
        )
    }
    
    func favourite(id: Int, params: NSDictionary?, completion: @escaping (_ error: Error?) -> ()) {
        post("1.1/favorites/create.json?id=\(id)", parameters: params, success: { (operation: URLSessionDataTask!, response: Any?) -> Void in
            print("[DEBUG] favourited tweet with id: \(id)")
            completion(nil)
        }, failure: { (operation: URLSessionDataTask?, error: Error?) -> Void in
            print("[DEBUG] Error favouriting tweet with id: \(id)")
            completion(error as Error?)
        })
    }
    
    func unfavourite(id: Int, params: NSDictionary?, completion: @escaping (_ error: Error?) -> ()) {
        post("1.1/favorites/destroy.json?id=\(id)", parameters: params, success: { (operation: URLSessionDataTask!, response: Any?) -> Void in
            print("[DEBUG] unfavourite tweet with id: \(id)")
            completion(nil)
        }, failure: { (operation: URLSessionDataTask?, error: Error?) -> Void in
            print("[DEBUG] Error unfavouriting tweet with id: \(id)")
            completion(error as Error?)
        })
    }
    
    func tweetStatus(status: String, params: NSDictionary?) {
        post("/1.1/statuses/update.json?status=\(status)", parameters: params, progress: { (Progress) in
            
        }, success: { (URLSessionDataTask, Any) in
            print("[DEBUG] Tweeting status: \(status)")
        }) { (URLSessionDataTask, Error) in
            print(Error)
        }
    }
}
