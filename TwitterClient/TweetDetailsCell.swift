
//
//  TweetDetailsCell.swift
//  Birdhouse-TwitterClient
//
//  Created by Sean Nam on 3/6/17.
//  Copyright © 2017 Sean Nam. All rights reserved.
//

import UIKit

class TweetDetailsCell: UITableViewCell {

    @IBOutlet weak var retweetedByImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var retweetedByLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoritesCountLabel: UILabel!
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!

    var tweet: Tweet! {
        didSet {
            
            if let profileImageUrl = tweet?.user?.profileUrl {
                self.profileImageView.setImageWith(profileImageUrl)
            }
            
            self.nameLabel.text = tweet.user?.name!
            self.usernameLabel.text = ("@\(tweet.user!.screenname!)")
            
            if let timestamp = tweet?.timestamp {
                self.timestampLabel.text = "\(timestamp)"
            }
            
            self.tweetLabel.text = tweet?.text!
            
            self.retweetCountLabel.text = String(tweet.retweetCount)
            self.favoritesCountLabel.text = String(tweet.favoritesCount)
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
