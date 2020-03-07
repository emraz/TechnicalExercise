//
//  APIManager.swift
//  TechnicalExercise
//
//  Created by Mahmudul Hasan on 2020/3/7.
//  Copyright © 2020 Mahmudul Hasan. All rights reserved.
//

import UIKit

class APIManager: NSObject {
    
    static let sharedInstance = APIManager()
    let session = URLSession.shared
    let FlickerFeedURL = URL(string:"https://www.flickr.com/services/feeds/photos_public.gne?lang=en-us&format=json&nojsoncallback=1")!
    
    func makeRequestToGetFeeds(completion: @escaping completionHandlerWithSucessAndResultsData) -> Void {
        
        session.dataTask(with: FlickerFeedURL) { data, response, error in
            
            var dataArray = [FeedData]()
            
            if error != nil || data == nil {
                print("Client error!")
                completion(false, "Client error!", dataArray)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                completion(false, "Server error!", dataArray)
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                completion(false, "Wrong MIME type!", dataArray)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                //print(json)

                if let result = ((json as AnyObject)["items"] as? NSArray) {
                    for item in result {
                        if let doc = item as? [String : AnyObject] {
                            let info = FeedData.init(data: doc)
                            dataArray.append(info)
                        }
                    }
                    completion(true, "Success", dataArray)
                }
            } catch {
                print("JSON error: \(error.localizedDescription)")
                completion(false, "JSON error: \(error.localizedDescription)", dataArray)
            }
        }.resume()
    }
}
