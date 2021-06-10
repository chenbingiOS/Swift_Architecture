//
//  AppDelegate.swift
//  Recordings
//
//  Created by mtAdmin on 2021/6/10.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let splitViewController = window!.rootViewController as! UISplitViewController
        splitViewController.delegate = self
        splitViewController.preferredDisplayMode = .allVisible
        
        return true
    }
}

extension AppDelegate: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        guard let topAsDetailController = (secondaryViewController as? UINavigationController)?.topViewController as? PlayViewController else {
            return false
        }
        
        if topAsDetailController.recording == nil {
            return true
        }
        
        return false
    }
}

