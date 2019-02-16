//
//  LoginViewController.swift
//  
//
//  Created by Ariel McCarthy on 2/14/19.
//

import UIKit

class LoginViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton(_ sender: Any)
    {
        let twitterURL = "https://api.twitter.com/oauth/request_token"
        
        print("in")
        TwitterAPICaller.client?.login(url: twitterURL, success: {
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: { (Error) in
            print("Login failed")
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
