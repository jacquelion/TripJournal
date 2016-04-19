//
//  InstagramClient.swift
//  TripJournal
//
//  Created by Jacqueline Sloves on 4/19/16.
//  Copyright © 2016 Jacqueline Sloves. All rights reserved.
//

import Foundation

//MARK: - InstagramClient : NSObject 

class InstagramClient : NSObject {

    var session = NSURLSession.sharedSession()
    
    var code: String? = nil
    
    //MARK: Initializers
    
    override init() {
        super.init()
    }
    
    // MARK: Shared Instance
    class func sharedInstance() -> InstagramClient {
        struct Singleton {
            static var sharedInstance = InstagramClient()
        }
        return Singleton.sharedInstance
    }
    
    //MARK: GET
    func taskForGETMethod(method: String, var parameters: [String: AnyObject], completionHandlerForGET: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
    
        //Set Parameters
        parameters[ParameterKeys.clientId] = Constants.ClientId
        parameters[ParameterKeys.redirectURI] = Constants.RedirectURI
        parameters[ParameterKeys.responseType] = ParameterValues.code
        
        var url = instagramURLFromParameters(parameters, withPathExtension: method)
        print("REQUEST URL: ", url)
        
        //Build URL, Configure request
        let request = NSMutableURLRequest(URL: url)
        
        //Make the Request
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGET(result: nil, error: NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForGET)
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
        
    }
    
    //MARK: POST
    
    func taskForPostMethod(method: String, var parameters: [String: AnyObject], jsonBody: String, completionHandlerForPOST: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        //Set Parameters
        //Build URL, Configure Request
        var url = instagramURLFromParameters(parameters, withPathExtension: method)
        print("REQUEST URL: ", url)
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        //request.addValue()
        request.HTTPBody = jsonBody.dataUsingEncoding(NSUTF8StringEncoding)
        
        //Make Request
        let task = session.dataTaskWithRequest(request) {(data, response, error) in
        
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForPOST(result: nil, error: NSError(domain: "taskForPOSTMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForPOST)
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
    
    }
    
    
    //MARK: Helpers
    
    //given RAW JSON, return a usable Foundation object
    private func convertDataWithCompletionHandler(data: NSData, completionHandlerForConvertData: (result: AnyObject!, error: NSError?) -> Void) {
        var parsedResult: AnyObject!
        do {
            parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(result: nil, error: NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandlerForConvertData(result: parsedResult, error: nil)
    }
    
    //create a URL from parameters
    private func instagramURLFromParameters(parameters: [String: AnyObject], withPathExtension: String? = nil) -> NSURL {
        
        let components = NSURLComponents()
        components.scheme = InstagramClient.Constants.ApiScheme
        components.host = InstagramClient.Constants.ApiHost
        components.path = InstagramClient.Constants.ApiPath + (withPathExtension ?? "")
        components.queryItems = [NSURLQueryItem]()

        for (key, value) in parameters {
            let queryItem = NSURLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.URL!
    }
}
