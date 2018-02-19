//
//  AppDelegate.swift
//  Todoey
//
//  Created by Devin Keel on 2/10/18.
//  Copyright © 2018 Devin Keel. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        //print(Realm.Configuration.defaultConfiguration.fileURL)

        do {
            _ = try Realm()
        } catch {
            print("Error initializing new realm, \(error)")
        }
        return true
    }
}

