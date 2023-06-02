import Foundation
import UIKit
import SnapKit

protocol LoginViewDelegate: AnyObject {
    func didTapLoginButton()
    func signUpButton()
}

class LoginView: UIView {
    
    // MARK: UI Elements
    private var blurVisualEffectView: UIVisualEffectView!
    private var titleLoginLabel: UILabel!
    private var loginButton: UIButton!
    private var orLoginWithLabel: UILabel!
    private var loginFbButton: UIButton!
    private var loginGoogleButton: UIButton!
    private var doNotHaveAnAccount: UILabel!
    private var signUpButton: UIButton!
    
    //MARK: Delegate
    weak var delegate: LoginViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        let blurView = UIBlurEffect(style: .light)
        blurVisualEffectView = UIVisualEffectView(effect: blurView)
        blurVisualEffectView.layer.borderColor = UIColor.gray.cgColor
        blurVisualEffectView.layer.borderWidth = 1.0
        blurVisualEffectView.layer.cornerRadius = 10.0
        blurVisualEffectView.layer.masksToBounds = true
        
        titleLoginLabel = UILabel()
        titleLoginLabel.text = "Login"
        titleLoginLabel.clipsToBounds = true
        titleLoginLabel.layer.masksToBounds = false
        titleLoginLabel.numberOfLines = 0
        titleLoginLabel.textColor = UIColor.white
        titleLoginLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLoginLabel.textAlignment = .left
        
        loginButton = UIButton()
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        loginButton.backgroundColor = .blue
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 7.0
        
        orLoginWithLabel = UILabel()
        orLoginWithLabel.text = "Or, login with.."
        orLoginWithLabel.font = UIFont.systemFont(ofSize: 15)
        orLoginWithLabel.clipsToBounds = true
        orLoginWithLabel.textColor = .white
        orLoginWithLabel.layer.masksToBounds = false
        orLoginWithLabel.textAlignment = .center
        
        loginFbButton = UIButton()
        loginFbButton.backgroundColor = .white
        loginFbButton.setTitle("Login with Facebook", for: .normal)
        loginFbButton.setTitleColor(.black, for: .normal)
        loginFbButton.layer.cornerRadius = 7.0
        
        loginGoogleButton = UIButton()
        loginGoogleButton.backgroundColor = .white
        loginGoogleButton.setTitle("Login with Google", for: .normal)
        loginGoogleButton.setTitleColor(.black, for: .normal)
        loginGoogleButton.layer.cornerRadius = 7.0
        
        doNotHaveAnAccount = UILabel()
        doNotHaveAnAccount.text = "Don't have an account?"
        doNotHaveAnAccount.textColor = .white
        
        signUpButton = UIButton()
        signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        signUpButton.setTitle("Sign up", for: .normal)
        signUpButton.setTitleColor(.blue, for: .normal)
        
        addSubview(titleLoginLabel)
        addSubview(loginButton)
        addSubview(orLoginWithLabel)
        addSubview(loginFbButton)
        addSubview(loginGoogleButton)
        addSubview(doNotHaveAnAccount)
        addSubview(signUpButton)
        addSubview(blurVisualEffectView)
        
        bringSubviewToFront(titleLoginLabel)
        bringSubviewToFront(loginButton)
        bringSubviewToFront(orLoginWithLabel)
        bringSubviewToFront(loginFbButton)
        bringSubviewToFront(loginGoogleButton)
        bringSubviewToFront(doNotHaveAnAccount)
        bringSubviewToFront(signUpButton)
    }
    
    @objc func handleLogin() {
        delegate?.didTapLoginButton()
    }
    @objc func handleSignUp(){
        delegate?.signUpButton()
    }
    
    func setupConstraints() {
        blurVisualEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLoginLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(15)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(titleLoginLabel.snp.bottom).offset(20)
            make.height.equalTo(40)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
        }
        
        orLoginWithLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        loginFbButton.snp.makeConstraints { make in
            make.top.equalTo(orLoginWithLabel.snp.bottom).offset(15)
            make.height.equalTo(40)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
        }
        
        loginGoogleButton.snp.makeConstraints { make in
            make.top.equalTo(loginFbButton.snp.bottom).offset(15)
            make.height.equalTo(40)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
        }
        
        doNotHaveAnAccount.snp.makeConstraints { make in
            make.top.equalTo(loginGoogleButton.snp.bottom).offset(15)
            make.left.equalTo(self).offset(50)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(loginGoogleButton.snp.bottom).offset(15)
            make.left.equalTo(doNotHaveAnAccount.snp.right).offset(10)
            make.centerY.equalTo(doNotHaveAnAccount)
        }
    }
}
