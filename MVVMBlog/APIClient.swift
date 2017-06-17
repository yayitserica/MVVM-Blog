//
//  APIClient.swift
//  MVVMBlog
//
//  Created by Erica Millado on 6/16/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import UIKit

//1 - This APIClient will be called by the viewModel to get our top 100 app data.
class APIClient: NSObject {
    
    //2 - the completion handler will be executed after our top 100 app data is fetched
    // our completion handler will include an optional array of NSDictionaries parsed from our retrieved JSON object
    func fetchAppList(completion: @escaping ([NSDictionary]?) -> Void) {
        
        //3 - unwrap our API endpoint
        guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/100/explicit/json") else {
            print("Error unwrapping URL"); return }
        
        //4 - create a session and dataTask on that session to get data/response/error
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            //5 - unwrap our returned data
            guard let unwrappedData = data else { print("Error getting data"); return }
            
            do {
                //6 - create an object for our JSON data and cast it as a NSDictionary
                // .allowFragments specifies that the json parser should allow top-level objects that aren't NSArrays or NSDictionaries.
                if let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as? NSDictionary {
                    
                    //7 - create an array of dictionaries from
                    if let apps = responseJSON.value(forKeyPath: "feed.results") as? [NSDictionary] {
                        
                        //8 - set the completion handler with our apps array of dictionaries
                        completion(apps)
                    }
                }
            } catch {
                //9 - if we have an error, set our completion with nil
                completion(nil)
                print("Error getting API data: \(error.localizedDescription)")
            }
        }
        //10 -
        dataTask.resume()
    }

}
