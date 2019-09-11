//
//  AppDelegate.swift
//  BanjoSquare
//
//  Created by Carlos Jimenez on 9/10/19.
//  Copyright © 2019 Carlos Jimenez. All rights reserved.
//

import UIKit
import BanjoLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = DashboardFactory().getDashboardViewController()
        return true
    }

}
