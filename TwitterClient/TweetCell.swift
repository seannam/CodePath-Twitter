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
    
    var tweet: Tweet! {
        didSet {
            print("[DEBUG] TweetCell Class")
            
            if let profileImageUrl = tweet?.profileImageLink {
                self.profileImageView.setImageWith(profileImageUrl)
            }
            
            self.nameLabel.text = tweet?.name
            self.usernameLabel.text = tweet?.screenname
            self.timePostedLabel.text = "\(tweet?.timestamp)"
            self.tweetLabel.text = tweet?.text
            
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
