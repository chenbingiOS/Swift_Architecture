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
    
    
    // MARK: 状态恢复功能
    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        true
    }
    
    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        true
    }
}

// iPad 左右分栏支持
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

