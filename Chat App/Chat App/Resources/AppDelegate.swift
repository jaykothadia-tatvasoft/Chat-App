//
//  AppDelegate.swift
//  Chat App
//
//  Created by MAC108 on 10/03/22.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared.enable = true
        FirebaseApp.configure()
        
        if Auth.auth().currentUser?.uid != nil {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatsNavController")
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
        }
        
        return true
    }

}

