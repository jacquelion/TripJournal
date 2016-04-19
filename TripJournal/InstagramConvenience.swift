//
//  InstagramConvenience.swift
//  TripJournal
//
//  Created by Jacqueline Sloves on 4/19/16.
//  Copyright © 2016 Jacqueline Sloves. All rights reserved.
//

import Foundation
import UIKit

extension InstagramClient {
    
    //Refer to the docs for further instruction: https://www.instagram.com/developer/authentication/
    //Step 1: Direct User to Authorization URL
    //Step 2: Receive the redirect from Instagram
    //Step 3: Request the Access Token
    
    func authenticateWithViewController(hostViewController: UIViewController, completionHandlerForAuth: (success: Bool, errorString: String?) -> Void) {
        
        getCode() { (success, code, errorString) in
            
            if success {
                self.code = code
        
                self.loginWithCode(hostViewController) { (success, errorString) in
                    if (success) {
                        
                    } else {
                        completionHandlerForAuth(success: success, errorString: errorString)
                    }
                }
                } else {
                    completionHandlerForAuth(success: success, errorString: errorString)
                }
            }
        }
        
    private func getCode(completionHandlerForCode: (success: Bool, code: String?, errorString: String?) -> Void) {
        let parameters = [String: AnyObject]()
        
        taskForGETMethod(Methods.Authorize, parameters: parameters) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                print(error)
                completionHandlerForCode(success: false, code: nil, errorString: "Login Failed (Request Token).")
            } else {
                if let code = results[InstagramClient.JSONResponseKeys.accessToken] as? String {
                    completionHandlerForCode(success: true, code: code, errorString: nil)
                } else {
                    print("Could not find \(InstagramClient.JSONResponseKeys.accessToken) in \(results)")
                    completionHandlerForCode(success: false, code: nil, errorString: "Login Failed (Request Token).")
                }
            }
        }
    }
    
    private func loginWithCode(hostViewController: UIViewController, completionHandlerForLogin:(success: Bool, errorString: String?) -> Void) {
        
        let webAuthViewController = hostViewController.storyboard!.instantiateViewControllerWithIdentifier("InstagramAuthViewController") as! InstagramAuthViewController
        
        //webAuthViewController.urlRequest = request
        //webAuthViewController.requestToken = requestToken
        webAuthViewController.completionHandlerForView = completionHandlerForLogin
        
        let webAuthNavigationController = UINavigationController()
        webAuthNavigationController.pushViewController(webAuthViewController, animated: false)
        
        performUIUpdatesOnMain {
            hostViewController.presentViewController(webAuthNavigationController, animated: true, completion: nil)
        }
    
    }
        
}