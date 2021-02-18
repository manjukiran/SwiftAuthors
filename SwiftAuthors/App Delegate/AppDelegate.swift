//
//  AppDelegate.swift
//  SwiftAuthors
//
//  Created by Manju Kiran on 18/02/2021.
//  Copyright © 2021 Manju Kiran. All rights reserved.
//

import UIKit


import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.setupAppTheme()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Save any contexts here before quitting
    }
    
    func setupAppTheme(){
        AppTheme.applyTheme()
    }
}

