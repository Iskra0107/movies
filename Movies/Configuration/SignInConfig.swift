//
//  SignInConfig.swift
//  Movies
//
//  Created by Iskra Gjorgjievska on 24.4.23.
//

import Foundation
import GoogleSignIn

class SignInStruct {
    
    static private let config = GIDConfiguration(clientID: "353695637880-797n53ul1cbh2kavu95thuoa5appbql8.apps.googleusercontent.com")
    
    static func configurate() {
        GIDSignIn.sharedInstance.configuration = config
    }
    
    static func handleSignInButton(vc: UIViewController, completion: @escaping (Bool, User?, Error?) -> Void) {
        print(GIDSignIn.sharedInstance.currentUser ?? "")
        GIDSignIn.sharedInstance.signIn(withPresenting: vc) { signInResult, error in
            if let error = error {
                completion(false, nil, error)
                return
            }
            guard let signInResult = signInResult else {
                completion(false, nil, nil)
                return
            }
            let googleUser = signInResult.user
            let emailAddress = googleUser.profile?.email
            let user = User(name: googleUser.profile?.name, email: googleUser.profile?.email, userId: googleUser.userID)
            completion(true, user, nil)
        }
    }
}
