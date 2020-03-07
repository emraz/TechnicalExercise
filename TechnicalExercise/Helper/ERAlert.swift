//
//  ERAlert.swift
//  TechnicalExercise
//
//  Created by Mahmudul Hasan on 2020/3/8.
//  Copyright © 2020 Mahmudul Hasan. All rights reserved.
//

import UIKit

class ERAlert: NSObject {
    
    class func showAlert(_ title : String, message: String, isCancel: Bool, okButtonTitle: String, cancelButtonTitle: String, completion: @escaping (Bool) -> ()) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: okButtonTitle, style: .default) { action -> Void in
            completion(true)
        }
        alertController.addAction(okButton)
        
        if isCancel {
            
            let cancelButton = UIAlertAction(title: cancelButtonTitle, style: .cancel){ action -> Void in
                completion(false)
            }
            alertController.addAction(cancelButton)
        }
        
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert + 1;
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
    }

}
