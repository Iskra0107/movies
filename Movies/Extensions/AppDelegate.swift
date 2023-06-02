////
////  AppDelegate.swift
////  Movies
////
////  Created by Iskra Gjorgjievska on 19.4.23.
////
import UIKit
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            guard application.connectedScenes.first?.delegate is SceneDelegate else {
                return
            }
            if error != nil || user == nil {
            } else {
            }
        }
        SignInStruct.configurate()
        return true
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        var handled: Bool
        handled = GIDSignIn.sharedInstance.handle(url)
        if handled {
            return true
        }
        return true
    }
}

