//
//  CustomCollectionViewCell.swift
//  TechnicalExercise
//
//  Created by Mahmudul Hasan on 2020/3/7.
//  Copyright © 2020 Mahmudul Hasan. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var feedImageView: UIImageView!
    
    func setImageFromUrl(ImageURL :String) {
        self.feedImageView.image = UIImage.init(named: "placeholder")

       URLSession.shared.dataTask( with: NSURL(string:ImageURL)! as URL, completionHandler: {
          (data, response, error) -> Void in
          DispatchQueue.main.async {
             if let data = data {
                self.feedImageView.image = UIImage(data: data)
             }
          }
       }).resume()
    }
    
}
