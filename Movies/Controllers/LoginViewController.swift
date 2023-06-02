//
//  SplashViewController.swift
//  Movies
//
//  Created by Iskra Gjorgjievska on 19.4.23.
//
import UIKit
import SnapKit
import GoogleSignIn

final class LoginViewController: UIViewController {
    
    // MARK: UI Elements
    private var backgroundSplashImageView: UIImageView!
    private var googleVisualEffectView: UIVisualEffectView!
    private var googleButton: UIButton!
    
    //MARK: View for Login
    private var loginView: LoginView!
    private var userCredentialsView: UserCredentials!
    private var signUpView: SignUpView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        
        googleButton.isHidden = true
        effectHide()
    }
    
    func effectHide(){
        if googleButton.isHidden {
            googleVisualEffectView.isHidden = true
        }
    }
    
    private func setupViews() {
        backgroundSplashImageView = UIImageView()
        backgroundSplashImageView.image = UIImage(named: "Splash")
        
        let blur = UIBlurEffect(style: .light)
        googleVisualEffectView = UIVisualEffectView(effect: blur)
        googleVisualEffectView.layer.borderColor = UIColor.gray.cgColor
        googleVisualEffectView.layer.borderWidth = 1.0
        googleVisualEffectView.layer.cornerRadius = 10.0
        googleVisualEffectView.layer.masksToBounds = true
        
        googleButton = UIButton(type: .custom)
        googleButton.setImage(UIImage(named: "google-button"), for: .normal)
        googleButton.addTarget(self, action: #selector(self.handleGoogleSignInButton), for: .touchUpInside)
        
        loginView = LoginView()
        loginView.delegate = self
        
        loginView.layer.cornerRadius = 15.0
        
        userCredentialsView = UserCredentials()
        userCredentialsView.delegate = self
        
        signUpView = SignUpView()
        signUpView.delegate = self
        
        view.addSubview(backgroundSplashImageView)
        view.addSubview(googleVisualEffectView)
        view.addSubview(googleButton)
        view.addSubview(loginView)
        view.addSubview(userCredentialsView)
        view.addSubview(signUpView)
    }
    
    @objc func handleGoogleSignInButton(_ sender: Any) {
        SignInStruct.handleSignInButton(vc: self) { success, user, error in
            if success {
                if let user = user {
                    let data = try? JSONEncoder().encode(user)
                    UserDefaults.standard.set(data, forKey: "userCredentials")
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    self.navigationController?.pushViewController(TabBarViewController(), animated: true)
                } else {
                    print("User not found")
                }
            } else {
                let loginFailViewController = LoginFailureViewController()
                self.present(loginFailViewController, animated: true, completion: nil)
                print(error ?? "Unknown error happened")
            }
        }
    }
    
    private func setupConstraints(){
        backgroundSplashImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        googleVisualEffectView.snp.makeConstraints { make in
            make.top.equalTo(600)
            make.left.equalTo(view).offset(50)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        googleButton.snp.makeConstraints { make in
            make.edges.equalTo(googleVisualEffectView)
        }
        
        loginView.snp.makeConstraints { make in
            make.height.equalTo(view).dividedBy(2.5)
            make.left.right.bottom.equalTo(view)
        }
        userCredentialsView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
        signUpView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
    }
}

extension LoginViewController: LoginViewDelegate {
    func didTapLoginButton() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, animations: {
                self.loginView.snp.remakeConstraints { make in
                    make.top.equalTo(self.view.snp.bottom)
                    make.left.right.bottom.equalTo(self.view)
                }
                self.view.layoutIfNeeded()
            }, completion: {_ in
                UIView.animate(withDuration: 0.5, animations: {
                    self.userCredentialsView.snp.remakeConstraints { make in
                        make.height.equalTo(self.view).dividedBy(2.5)
                        make.left.right.bottom.equalTo(self.view)
                    }
                    self.view.layoutIfNeeded()
                })
            })
        }
    }
    
    func signUpButton(){
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, animations: {
                self.loginView.snp.remakeConstraints { make in
                    make.top.equalTo(self.view.snp.bottom)
                    make.left.right.bottom.equalTo(self.view)
                }
                self.view.layoutIfNeeded()
            }, completion: {_ in
                UIView.animate(withDuration: 0.5, animations: {
                    self.signUpView.snp.remakeConstraints { make in
                        make.height.equalTo(self.view).dividedBy(1.8)
                        make.left.right.bottom.equalTo(self.view)
                    }
                    self.view.layoutIfNeeded()
                })
            })
        }
    }
}

extension LoginViewController: UserCredentialsDelegate {
    func didTapLogInButton() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, animations: {
                self.userCredentialsView.snp.remakeConstraints { make in
                    make.top.equalTo(self.view.snp.bottom)
                    make.left.right.bottom.equalTo(self.view)
                }
                self.view.layoutIfNeeded()
            }, completion: {_ in
                UIView.animate(withDuration: 0.5, animations: {
                    self.loginView.snp.remakeConstraints { make in
                        make.height.equalTo(self.view).dividedBy(2.5)
                        make.left.right.bottom.equalTo(self.view)
                    }
                    self.view.layoutIfNeeded()
                })
            })
        }
    }
    
    func didTapRegisterButton() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, animations: {
                self.userCredentialsView.snp.remakeConstraints { make in
                    make.top.equalTo(self.view.snp.bottom)
                    make.left.right.bottom.equalTo(self.view)
                }
                self.view.layoutIfNeeded()
            }, completion: {_ in
                UIView.animate(withDuration: 0.5, animations: {
                    self.signUpView.snp.remakeConstraints { make in
                        make.height.equalTo(self.view).dividedBy(1.8)
                        make.left.right.bottom.equalTo(self.view)
                    }
                    self.view.layoutIfNeeded()
                })
            })
        }
    }
}

extension LoginViewController: SignUpViewDelegate {
    func didTaploginButton(){
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, animations: {
                self.signUpView.snp.remakeConstraints { make in
                    make.top.equalTo(self.view.snp.bottom)
                    make.left.right.bottom.equalTo(self.view)
                }
                self.view.layoutIfNeeded()
            }, completion: {_ in
                UIView.animate(withDuration: 0.5, animations: {
                    self.loginView.snp.remakeConstraints { make in
                        make.height.equalTo(self.view).dividedBy(2.5)
                        make.left.right.bottom.equalTo(self.view)
                    }
                    self.view.layoutIfNeeded()
                })
            })
        }
        
    }
}
