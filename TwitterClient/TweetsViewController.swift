//
//  TweetsViewController.swift
//  TwitterClient
//
//  Created by Sean Nam on 3/1/17.
//  Copyright © 2017 Sean Nam. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets:[Tweet]) in
            
            self.tweets = tweets
            self.tableView.reloadData()
            /*
            for tweet in tweets {
                print(tweet.text!)
            }
            */
        }) {(error:Error) -> () in
            print(error.localizedDescription)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        let tweet = tweets[indexPath.row]
        
        cell.tweet = tweet
        
        if tweet.retweeted {
            cell.retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControlState())
        } else {
            cell.retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControlState())
        }
        if tweet.favourited  {
            cell.favouriteButton.setImage(UIImage(named: "favor-icon-red"), for: UIControlState())
        } else {
            cell.favouriteButton.setImage(UIImage(named: "favor-icon"), for: UIControlState())
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection numOfRowsInSection: Int) -> Int {
        return self.tweets?.count ?? 0
    }

    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }
    
    
    @IBAction func onRetweet(_ sender: AnyObject) {
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! TweetCell
        let indexPath = tableView.indexPath(for: cell)
        let tweet = tweets![indexPath!.row]
        let path = tweet.id
        
        if tweet.retweeted == false {
            TwitterClient.sharedInstance!.retweet(id: path, params: nil) { (error) -> () in
                self.tweets![indexPath!.row].retweetCount += 1
                tweet.retweeted = true
                self.tableView.reloadData()
            }
        } else if tweet.retweeted == true {
            TwitterClient.sharedInstance!.unretweet(id: path, params: nil, completion: { (error) -> () in
                self.tweets![indexPath!.row].retweetCount -= 1
                tweet.retweeted = false
                self.tableView.reloadData()
            })
        }
        
    }
    
    @IBAction func onFavorite(_ sender: AnyObject) {
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! TweetCell
        
        let indexPath = tableView.indexPath(for: cell)
        let tweet = tweets![indexPath!.row]
        
        let path = tweet.id
        if tweet.favourited == false {
            TwitterClient.sharedInstance!.favourite(id: path, params: nil) { (error) -> () in
                self.tweets![indexPath!.row].favoritesCount += 1
                tweet.favourited = true
                self.tableView.reloadData()
            }
        } else if tweet.favourited == true {
            TwitterClient.sharedInstance!.favourite(id: path, params: nil, completion:  { (error) -> () in
                self.tweets![indexPath!.row].favoritesCount -= 1
                tweet.favourited = false
                self.tableView.reloadData()
            })
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TweetDetailsSegue" {
            let cell = sender as! TweetCell
            
            let indexPath = tableView.indexPath(for: cell)
            let tweet = self.tweets![(indexPath?.row)!]
            
            let detailsVC = segue.destination as! TweetsDetailsViewController
            detailsVC.tweet = tweet
            
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
