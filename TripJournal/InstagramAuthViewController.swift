//
//  InstagramAuthViewController.swift
//  TripJournal
//
//  Created by Jacqueline Sloves on 4/19/16.
//  Copyright © 2016 Jacqueline Sloves. All rights reserved.
//

import UIKit

class InstagramAuthViewController: UIViewController {
    
//  let urlString = "https://api.instagram.com/oauth/authorize/?client_id=60e0fe0b74e849ec83f81f18b781b88f&redirect_uri=https://www.instagram.com/&response_type=code"
    var urlRequest: NSURLRequest? = nil //this is passed in when view controller is instantiated
    var requestToken: String? = nil
    var accessToken: String! = nil
    var completionHandlerForView: ((success: Bool, errorString: String?) -> Void)? = nil
    
    //MARK: - Outlets

    @IBOutlet weak var webView: UIWebView!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        print("URLREQUEST: ", urlRequest)
        
        webView.delegate = self
        
        navigationItem.title = "Instagram Auth"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(InstagramAuthViewController.cancelAuth))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        if let urlRequest = urlRequest {
            webView.loadRequest(urlRequest)
        }
    }
    
    //MARK: - Cancel Auth Flow
    
    func cancelAuth() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

//MARK: - InstgramAuthViewController: UIWebViewDelegate

extension InstagramAuthViewController : UIWebViewDelegate {
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let url = request.URL
        var key: String
        var value: String

        if (url!.query != nil) {
            print("URL.Query", url!.query)
            key = (url!.query?.componentsSeparatedByString("=").first)!
            value = (url!.query?.componentsSeparatedByString("=").last)!
            print("Key, value: ", key, value)
            
            if key == "code" {
                let params = [String: AnyObject]()
                let jsonBody = "{\"client_id\": \"\(InstagramClient.Constants.ClientId)\",\"client_secret\":\"\(InstagramClient.Constants.ClientSecret)\", \"grant_type\":\"authorization_code\", \"redirect_uri\":\"\(InstagramClient.Constants.RedirectURI)\", \"code\":\"\(value)\"}"
                print(jsonBody)
                //let params: [String: AnyObject] = [ "client_id" : InstagramClient.Constants.ClientId, "client_secret" : InstagramClient.Constants.ClientSecret, "grant_type" : "authorization_code", "redirect_uri" : InstagramClient.Constants.RedirectURI, "code" : value]
                
                var codeValue = value
                print(codeValue)
                
                InstagramClient.sharedInstance().taskForPostMethod(InstagramClient.Methods.AccessToken, parameters: params, jsonBody: jsonBody) { (results, error) in
                    print(error?.localizedDescription)
                    print("RESULTS", results)
                }

                
            } else if key == "access_token" {
                accessToken = value
                print("ACCESS TOKEN: ", accessToken)
            }
            
            

            
        } else if (url!.fragment != nil) {
            key = (url?.fragment?.componentsSeparatedByString("=").first)!
            value = (url?.fragment?.componentsSeparatedByString("=").last)!
            print("Key, value: ", key, value)
            if key == "access_token" {
                accessToken = value as! String
                print("ACCESS TOKEN: ", accessToken)
            }

        }
        
        return true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        var urlString = ("https://www.instagram.com#access_token=\(accessToken)")
        print("Redirect URL String + Access Token: ", urlString)
        print("webView.request!.URL!.absoluteString: ", webView.request!.URL!.absoluteString)
        if webView.request!.URL!.absoluteString == InstagramClient.Constants.RedirectURI {
            dismissViewControllerAnimated(true) {
                self.completionHandlerForView!(success: true, errorString: nil)
            }
        } else if webView.request!.URL!.absoluteString == "" {
            dismissViewControllerAnimated(true) {
                self.completionHandlerForView!(success: true, errorString: nil)
            }
        }
    }
    
}
