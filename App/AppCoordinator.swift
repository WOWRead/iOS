
//
//  AppCoordinator.swift
//  App
//
//  Created by Remi Robert on 22/03/16.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit
import RxSwift

protocol UIViewControllerCoordinable {
    func start()
}

struct AppCoordinator {

    private var window: UIWindow
    private var rootController: UIViewController! {
        didSet {
            self.window.rootViewController = self.rootController
        }
    }
    
    init(window: UIWindow) {
        self.window = window
    }
    
    private func isLogged() -> Bool {
        //check if user already logged
        return false
    }
    
    private mutating func instanceLoginController() {
        if let vc = LoginViewController.instanceController(StoryBoards.Login) as? LoginViewController {
            vc.transitions = LoginTransitions(
                didLogin: {
                    self.instanceFeedController()
                }
            )
            self.rootController = UINavigationController(rootViewController: vc)
            vc.start()
        }
    }
    
    private mutating func instanceFeedController() {
        if let vc = FeedViewController.instanceController(StoryBoards.Detail) as? FeedViewController {
            self.rootController = UINavigationController(rootViewController: vc)
            vc.start()
        }
    }
    
    mutating func start() {
        self.isLogged() ? self.instanceFeedController() : self.instanceLoginController()
    }
}