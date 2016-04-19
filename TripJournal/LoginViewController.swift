//
//  LoginViewController.swift
//  TripJournal
//
//  Created by Jacqueline Sloves on 4/19/16.
//  Copyright © 2016 Jacqueline Sloves. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class LoginViewController : UIViewController {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var myWebView: UIWebView!
    
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        
        InstagramClient.sharedInstance().authenticateWithViewController(self) { (success, errorString) in
            performUIUpdatesOnMain {
                if success {
                    //TODO: instantiate next View Controller
                    print("SUCCESS")
                } else {
                    print("ERROR!!!!")
                }
            }
            
            //authenticateWithInstagram(usernameTextField.text, password: passwordTextField.text)
        }
        
    }
    
    //MARK: View LifeCycle
    
    override func viewDidLoad(){
        myWebView.hidden = true
       // InstagramAuthentication()
    }
    
    func InstagramAuthentication(){
        let urlString = "https://api.instagram.com/oauth/authorize/?client_id=60e0fe0b74e849ec83f81f18b781b88f&redirect_uri=https://www.instagram.com/&response_type=code"
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!)
        
        myWebView.hidden = false
        myWebView.loadRequest(request)
    }
    
    func authenticateWithInstagram(username: String!, password: String!){
        
        
        InstagramClient.sharedInstance().authenticateWithViewController(self) { (success, errorString) in
            performUIUpdatesOnMain {
                if success {
                    //TODO: instantiate next View Controller
                    print("SUCCESS")
                } else {
                    print("ERROR!!!!")
                }
            }
            
        }
        //        let session = NSURLSession.sharedSession()
        //        //TODO: make function: InstagramURLFromParameters
        //        let urlString = "https://api.instagram.com/oauth/authorize/?client_id=60e0fe0b74e849ec83f81f18b781b88f&redirect_uri=https://www.instagram.com/&response_type=code"
        //        let url = NSURL(string: urlString)
        //        let request = NSURLRequest(URL: url!)
        //
        //        let task = session.dataTaskWithRequest(request) { (data, response, error) in
        //            print("DATA: ", data)
        //            print("RESPONSE: ", response)
        //            print("ERROR: ", error)
        //            if error == nil {
        //                let parsedResult: AnyObject!
        //                do {
        //                    parsedResult = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
        //                    print("PARSED RESULT: ", parsedResult)
        //                } catch {
        //                    print("Could not parse data as JSON")
        //                    return
        //                }
        //                //self.requestAccessToken()
        //            } else {
        //                //TODO: Display error message to user
        //            }
        //        }
        //
        //        task.resume()
    }
    
    func requestAccessToken(){
        let session = NSURLSession.sharedSession()
        let request = NSURL(string: "")
        
    }
}