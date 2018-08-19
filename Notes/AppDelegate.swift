//
//  AppDelegate.swift
//  Notes
//
//  Created by Hitesh  Agarwal on 8/19/18.
//  Copyright © 2018 Hitesh  Agarwal. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
        print(CoreDataManager.shared.applicationDocumentDirectory)
        
        print("NSManagedObjectContext file = \( CoreDataManager.shared.managesObjectContext)")
        
        return true
    }
}

