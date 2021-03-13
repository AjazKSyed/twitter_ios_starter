//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Ajaz Syed on 3/5/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    var favorited:Bool = false
    var tweetId:Int = -1
    
    @IBOutlet weak var retweet: UIButton!
    @IBOutlet weak var Favorite: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func RetweetTweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (error) in
            print("Error in retweeting: \(error)")
            
        })
    }
    
    func setRetweeted(_ isRetweeted:Bool) {
        if(isRetweeted) {
            retweet.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweet.isEnabled = false
        } else {
            retweet.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweet.isEnabled = true
        }
    }
    

    func setFavorite(_ isFavorited:Bool) {
        favorited = isFavorited
        if(favorited) {
            Favorite.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else {
            Favorite.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    
    
    
    @IBAction func FavoriteTweet(_ sender: Any) {
        let tobeFav = !favorited
        if(tobeFav){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("Favorite did not succeed: \(error)")
                
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (error) in
                print("Unfavorite did not succeed: \(error)")
                
            })
        }
    }
}
