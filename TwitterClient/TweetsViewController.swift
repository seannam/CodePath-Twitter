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
            print("[DEBUG] Tweet count: \(tweets.count)")
            
            self.tableView.reloadData()
            print("[DEBUG] TweetsViewController: success")
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
        print("[DEBUG] TweetsViewController: cellForRowAt")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        
        print(indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection numOfRowsInSection: Int) -> Int {
        print("[DEBUG] TweetsViewController: numberOfRowsInSection")
        
        let count = self.tweets?.count ?? 0
        
        print("\(count)")
        
        return count
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
