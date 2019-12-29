//
//  AppDelegate.swift
//  Wasatta
//
//  Created by Said Abdulla on 10/8/18.
//  Copyright © 2018 Said Abdulla. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
//<<<<<<< HEAD
//
import GooglePlaces
import GoogleMaps
import FacebookCore
import GoogleSignIn

//
//internal let kMapsAPIKey = "AIzaSyArsHcgz7muLrV6BN-b-m3WRI-zEh8dt2I"
//
//
//=======
//import GoogleMaps
//import GooglePlaces
//>>>>>>> 8a763b242966b7f0df6235ac137b2b4b241b6b3e
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            // ...
        }
    }
    


    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
      //  UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Tajawal-Bold", size: 18)!,
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        ]
        
//        GIDSignIn.sharedInstance().clientID = "1014685492593-kab7vfvsus9th05t56q3c01858mq9sh8.apps.googleusercontent.com"

        // Initialize Google sign-in
        GIDSignIn.sharedInstance().clientID = "1014685492593-kab7vfvsus9th05t56q3c01858mq9sh8.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        
        
        GMSServices.provideAPIKey("AIzaSyBXcb6dk3opzm8gnejGxWKCvg9LCTWUtsc")
        GMSPlacesClient.provideAPIKey("AIzaSyBXcb6dk3opzm8gnejGxWKCvg9LCTWUtsc")
        print("temp path: \(NSTemporaryDirectory())")
        IQKeyboardManager.shared.enable = true
        
        if !UserDefaults.standard.bool(forKey: "didSee") {
            UserDefaults.standard.set(true, forKey: "didSee")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "lang")
            self.window?.rootViewController = viewController
            self.window?.makeKeyAndVisible()
        }
                

        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let appId: String = SDKSettings.appId
        if url.scheme != nil && url.scheme!.hasPrefix("fb\(appId)") && url.host ==  "authorize" {
            return SDKApplicationDelegate.shared.application(app, open: url, options: options)
        }

        return GIDSignIn.sharedInstance().handle(url as URL?,
                                                 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    
   

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        AppEventsLogger.activate(application)

    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    func presentHomeViewController(animated:Bool) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ads_vc")

        if animated {
            let options: UIViewAnimationOptions = [.transitionCrossDissolve, .curveEaseOut]
            
            UIView.transition(with: self.window!, duration: 0.4, options: options, animations: {
                self.window?.rootViewController = controller
            }, completion: nil)
            
        } else {
            self.window?.rootViewController = controller
        }
        
        
        
    }
    



}

