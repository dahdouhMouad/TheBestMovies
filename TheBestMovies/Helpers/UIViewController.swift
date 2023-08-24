//
//  UIViewController.swift
//  TheBestMovies
//
//  Created by Macbook Pro on 24/8/2023.
//

import Foundation
import UIKit

extension UIViewController {
    public func displayAlert(errorTitle: String, error: String) {
        
        let title = NSAttributedString(string: errorTitle, attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: .semibold),
            NSAttributedString.Key.foregroundColor : UIColor.black
        ])
        let message = NSAttributedString(string: error, attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13, weight: .regular),
            NSAttributedString.Key.foregroundColor : UIColor.black
        ])
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.setValue(title, forKey: "attributedTitle")
        alert.setValue(message, forKey: "attributedMessage")
        
        let okActionTitle = "ok".localized()
        let okAction = UIAlertAction(title: okActionTitle, style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}
