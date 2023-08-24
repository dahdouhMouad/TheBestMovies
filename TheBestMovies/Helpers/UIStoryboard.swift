//
//  UIStoryboard.swift
//  TheBestMovies
//
//  Created by Macbook Pro on 23/8/2023.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    public static func instantiate<T: UIViewController>(_ viewControllerType: T.Type, from storyboardName: String) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let className = String(reflecting: viewControllerType).components(separatedBy: ".").last ?? ""
        return storyboard.instantiateViewController(withIdentifier: className) as! T
    }
}
