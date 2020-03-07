//
//  PhotoInfo.swift
//  TechnicalExercise
//
//  Created by Mahmudul Hasan on 2020/3/7.
//  Copyright © 2020 Mahmudul Hasan. All rights reserved.
//

import UIKit

class FeedData: NSObject {
    
    var dataTitle = ""
    var dataLink = ""
    var dataMedia = ""
    var dataDataTaken = ""
    var dataDescription = ""
    var dataPublished = ""
    var dataAuthor = ""
    var dataAuthorID = ""
    var dataTags = ""
    
    convenience init(data: [String : AnyObject]) {
         self.init()
        
         if let title = data["title"] as? String {
             dataTitle = title
         }
        if let link = data["link"] as? String {
            dataLink = link
        }
        if let data = data["media"] as? [String: AnyObject] {
            if let media = data["m"] as? String {
                dataMedia = media
            }
        }
        if let dateTaken = data["date_taken"] as? String {
            dataDataTaken = dateTaken
        }
        if let desc = data["description"] as? String {
            dataDescription = desc
        }
        if let published = data["published"] as? String {
            dataPublished = published
        }
        if let author = data["author"] as? String {
            let start = author.index(author.startIndex, offsetBy: 22)
            let end = author.index(author.endIndex, offsetBy: -4)
            let range = start..<end
            let mySubstring = author[range]
            dataAuthor = String(mySubstring)
        }
        if let authorId = data["author_id"] as? String {
            dataAuthorID = authorId
        }
        if let tags = data["tags"] as? String {
            dataTags = tags
        }
    }
}
