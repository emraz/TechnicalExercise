//
//  ERProgressHud.swift
//  TechnicalExercise
//
//  Created by Mahmudul Hasan on 2020/3/7.
//  Copyright © 2020 Mahmudul Hasan. All rights reserved.
//

import UIKit

let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
let containerView = UIView()

class ERProgressHud {
    
    class func show (){
        
        containerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        let color = UIColor.gray
        let alphaColor = color.withAlphaComponent(0.5)
        containerView.backgroundColor = alphaColor
        
        activityIndicator.center =  CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)
        activityIndicator.color = UIColor.white
        activityIndicator.hidesWhenStopped = true
        
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            containerView.addSubview(activityIndicator)
            window.addSubview(containerView)
            activityIndicator.startAnimating()
        }
    }
    
    class func hide (){
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            containerView.removeFromSuperview()
        }
    }
}
