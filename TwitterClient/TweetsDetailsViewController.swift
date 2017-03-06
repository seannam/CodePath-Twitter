//
//  TweetsDetailsViewController.swift
//  Birdhouse-TwitterClient
//
//  Created by Sean Nam on 3/6/17.
//  Copyright © 2017 Sean Nam. All rights reserved.
//

import UIKit

class TweetsDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onReplyButton(_ sender: Any) {
    }

    
    @IBAction func onRetweetButton(_ sender: Any) {
        
        let path = tweet.id
        
        if tweet.retweeted == false {
            TwitterClient.sharedInstance!.retweet(id: path, params: nil) { (error) -> () in
                self.tweet.retweetCount += 1
                self.tweet.retweeted = true
                self.tableView.reloadData()
            }
        } else if tweet.retweeted == true {
            TwitterClient.sharedInstance!.unretweet(id: path, params: nil, completion: { (error) -> () in
                self.tweet.retweetCount -= 1
                self.tweet.retweeted = false
                self.tableView.reloadData()
            })
        }
    }
    
    @IBAction func onFavoriteButton(_ sender: Any) {

        let path = tweet.id
        
        if tweet.favourited == false {
            TwitterClient.sharedInstance!.favourite(id: path, params: nil) { (error) -> () in
                self.tweet.favoritesCount += 1
                self.tweet.favourited = true
                self.tableView.reloadData()
            }
        } else if tweet.favourited == true {
            TwitterClient.sharedInstance!.favourite(id: path, params: nil, completion:  { (error) -> () in
                self.tweet.favoritesCount -= 1
                self.tweet.favourited = false
                self.tableView.reloadData()
            })
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension TweetsDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetDetailsCell", for: indexPath) as! TweetDetailsCell
        
        cell.tweet = tweet
        
        cell.retweetedByLabel.text = ""
        
        
        if tweet.retweeted {
            cell.retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControlState())
        } else {
            cell.retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControlState())
        }
        if tweet.favourited  {
            cell.favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: UIControlState())
        } else {
            cell.favoriteButton.setImage(UIImage(named: "favor-icon"), for: UIControlState())
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection numOfRowsInSection: Int) -> Int {
        return 1
    }
}
