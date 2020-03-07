//
//  ViewController.swift
//  TechnicalExercise
//
//  Created by Mahmudul Hasan on 2020/3/7.
//  Copyright © 2020 Mahmudul Hasan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var feedDataList = [FeedData]()
    static let reuseIdentifier = "feedCell"
    @IBOutlet weak var feedCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        var width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        width = width - 10
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        feedCollectionView!.collectionViewLayout = layout
        
        getAllFeeds()
    }
    
    func getAllFeeds() -> Void {
        ERProgressHud.show()
        APIManager.sharedInstance.makeRequestToGetFeeds { (success, message, feedData)  in
            DispatchQueue.main.async {
                ERProgressHud.hide()
                if(success) {
                    self.feedDataList = feedData
                    self.feedCollectionView.reloadData()
                }
                else {
                    ERAlert.showAlert("Failed!", message: message, isCancel: false, okButtonTitle: "OK", cancelButtonTitle: "", completion: { (isAllowed) in
                    })
                }
            }
        }
    }
}

// MARK: - UICollectionViewDataSource protocol
extension ViewController : UICollectionViewDataSource {
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedDataList.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewController.reuseIdentifier, for: indexPath as IndexPath) as! CustomCollectionViewCell
        
        let data = feedDataList[indexPath.item]
        cell.authorNameLabel.text = data.dataAuthor
        cell.titleLabel.text = data.dataTitle
        cell.setImageFromUrl(ImageURL: data.dataMedia)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate protocol
extension ViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
}

// MARK: - Collection View Flow Layout Delegate
extension ViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = view.frame.width - 18.0
        let widthPerItem = availableWidth / 2.0
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

