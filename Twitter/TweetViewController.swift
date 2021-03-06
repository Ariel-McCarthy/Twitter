//
//  TweetViewController.swift
//  Twitter
//
//  Created by Ariel McCarthy on 2/18/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
   
    @IBOutlet weak var tweetText: UITextView!
    
    @IBAction func cancelButton(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweetButton(_ sender: Any)
    {
        if (!tweetText.text.isEmpty)
        {
            TwitterAPICaller.client?.postTweet(tweetString: tweetText.text, success:
            {
                self.dismiss(animated: true, completion: nil)
            },
            failure:
            { (error) in
                print ("Error: \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        }
        else
        {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tweetText.becomeFirstResponder()
    }
}
