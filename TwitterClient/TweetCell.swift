//
//  TweetCell.swift
//  TwitterClient
//
//  Created by Sean Nam on 3/1/17.
//  Copyright © 2017 Sean Nam. All rights reserved.
//

import UIKit
import AFNetworking

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timePostedLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favouriteCountLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favouriteButton: UIButton!
    
    
    var tweet: Tweet! {
        didSet {
            
            if let profileImageUrl = tweet?.user?.profileUrl {
                self.profileImageView.setImageWith(profileImageUrl)
            }
            
            self.nameLabel.text = tweet.user?.name!
            self.usernameLabel.text = ("@\(tweet.user!.screenname!)")
            //self.timePostedLabel.text = "\(tweet?.timestamp!)"
            self.tweetLabel.text = tweet?.text!
            

            self.retweetCountLabel.text = String(tweet.retweetCount)

            self.favouriteCountLabel.text = String(tweet.favoritesCount)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
