//
//  ProfileBodyCell.swift
//  Birdhouse-TwitterClient
//
//  Created by Sean Nam on 3/6/17.
//  Copyright © 2017 Sean Nam. All rights reserved.
//

import UIKit

class ProfileBodyCell: UITableViewCell {

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var statsSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var tweetsCountLabel: UILabel!
    
    @IBOutlet weak var followersCountLabel: UILabel!
    
    @IBOutlet weak var followingCountLabel: UILabel!
    
    var user: User! {
        didSet {
            
            if let profileImageUrl = user?.profileUrl {
                self.profilePicImageView.setImageWith(profileImageUrl)
            }
            
            if let backgroundImageUrl = user?.backgroundUrl {
                self.backgroundImageView.setImageWith(backgroundImageUrl)
            }
            
            self.nameLabel.text = user?.name!
            self.usernameLabel.text = ("@\(user!.screenname!)")
            
            if user?.tweetsCount != nil {
                self.tweetsCountLabel.text = "\(user!.tweetsCount!)"
            }
            
            if user?.followersCount != nil {
                self.followersCountLabel.text = "\(user!.followersCount!)"
            }
            if user?.friendsCount != nil {
                self.followingCountLabel.text = "\(user!.friendsCount!)"
            }
            
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
