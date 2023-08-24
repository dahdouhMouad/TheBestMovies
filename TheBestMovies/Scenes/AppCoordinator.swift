//
//  AppCoordinator.swift
//  TheBestMovies
//
//  Created by Macbook Pro on 23/8/2023.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    let window: UIWindow?
    
    lazy var rootViewController: UINavigationController = {
        var navigationController = UINavigationController(rootViewController: UIViewController())
        navigationController.setNavigationBarHidden(true, animated:false)
        return navigationController
    }()
    
    let apiClient: ApiClient = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json; charset=utf-8"]
        let apiClient = ApiClient(configuration: configuration)
        return apiClient
    }()

    // MARK: - Coordinator
    init(window: UIWindow?) {
        self.window = window
        
    }

    override func start() {
        guard let window = window else {
            return
        }
        
        window.rootViewController = self.rootViewController
        window.backgroundColor = .white
        window.makeKeyAndVisible()
  
        self.goToHome()
    }
    

    override func finish() {
       
    }
    
    // MARK: - Navigation
    
    func goToHome() {
        let homeCoordinator = HomeCoordinator(rootViewController: rootViewController, apiClient: apiClient)
        self.addChildCoordinator(homeCoordinator)
        homeCoordinator.start()
    }
   
}
