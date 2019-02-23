//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Ariel McCarthy on 2/16/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var reTweetButton: UIButton!
    
    @IBAction func favoriting(_ sender: Any)
    {
        let toBeFavorited = !favorited
        
        if(toBeFavorited)
        {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("Error: \(error)")
            })
        }
    }
    @IBAction func reTweeting(_ sender: Any)
    {
        
    }
    
    var favorited: Bool = false
    var tweetId: Int = -1
    
    func setFavorite(_ isFavorited:Bool)
    {
        favorited = isFavorited
        if(favorited)
        {
            favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else
        {
            favoriteButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
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
