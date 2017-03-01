//
//  TweetCell.swift
//  TwitterClient
//
//  Created by Sean Nam on 3/1/17.
//  Copyright © 2017 Sean Nam. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    var tweet: Tweet! {
        didSet {
            
//            
//            if let thumbnailURL = business.imageURL {
//                self.thumbImageView.setImageWith(thumbnailURL)
//            }
//            if let ratingsURL = business.ratingImageURL {
//                self.ratingsImageView.setImageWith(ratingsURL)
//            }
//            
//            nameLabel.text = business.name
//            distanceLabel.text = business.distance
//            reviewCountLabel.text = "\(business.reviewCount!) Reviews"
//            addressLabel.text = business.address
//            categoriesLabel.text = business.categories
//            
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
