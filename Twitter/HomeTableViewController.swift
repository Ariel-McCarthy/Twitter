//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Ariel McCarthy on 2/15/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    @IBAction func logout(_ sender: Any)
    {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        numTweets = 25
        
        // refresh definition
        refreshContol.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = refreshContol
        
        // fixes the height of the tweet cell
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 174
        
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        loadTweets()
    }
    
    var tweetArray = [NSDictionary]()
    var numTweets: Int!
    let refreshContol = UIRefreshControl()
    
    @objc func loadTweets()
    {
        
        let twitterURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let twitterParameters = ["count": numTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: twitterURL, parameters: twitterParameters as [String : Any], success: {(tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            for tweet in tweets
            {
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
            self.refreshContol.endRefreshing()
            
        }, failure: {(Error) in print("Could not load")
        })
    }
    
    func loadMoreTweets()
    {
        let twitterURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numTweets = numTweets + 25
        
        let twitterParams = ["count": numTweets]
        TwitterAPICaller.client?.getDictionariesRequest(url: twitterURL, parameters: twitterParams as [String : Any], success: { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            for tweet in tweets
            {
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
            self.refreshContol.endRefreshing()
            
        }, failure:
            { (Error) in
                print("Could not load")
            })
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for:  indexPath) as! TweetTableViewCell
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        cell.userNameLabel.text = user["name"] as? String
        cell.tweetLabel.text = tweetArray[indexPath.row]["text"] as? String
        //cell.timeLabel.text = getRelativeTime(timeString: (tweetArray[indexPath.row]["created_at" as? String])!)
        cell.setFavorite(tweetArray[indexPath.row]["favorited"] as! Bool)
        cell.tweetId = tweetArray[indexPath.row]["id"] as! Int
        cell.setRetweeted(tweetArray[indexPath.row]["retweeted"] as! Bool)
        
        
        let imageURL = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageURL!)
        
        if let imageData = data
        {
            cell.profileImageView.image = UIImage(data: imageData)
        }
        
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        if indexPath.row + 1 == tweetArray.count
        {
            loadMoreTweets()
        }
    }
}
