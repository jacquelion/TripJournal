//
//  InstagramAuthViewController.swift
//  TripJournal
//
//  Created by Jacqueline Sloves on 4/19/16.
//  Copyright © 2016 Jacqueline Sloves. All rights reserved.
//

import UIKit

class InstagramAuthViewController: UIViewController {
    
    var urlRequest: NSURLRequest? = nil
    var requestToken: String? = nil
    var completionHandlerForView: ((success: Bool, errorString: String?) -> Void)? = nil
    
    //MARK: - Outlets

    @IBOutlet weak var webView: UIWebView!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
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
    func webViewDidFinishLoad(webView: UIWebView) {
        if webView.request!.URL!.absoluteString == "" {
            dismissViewControllerAnimated(true) {
                self.completionHandlerForView!(success: true, errorString: nil)
            }
        }
    }
    
}
