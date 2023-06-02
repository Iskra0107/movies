//
//  LoginCredentialsView.swift
//  Movies
//
//  Created by Iskra Gjorgjievska on 29.5.23.
//

import Foundation
import UIKit
import SnapKit

protocol UserCredentialsDelegate: AnyObject {
    func didTapRegisterButton()
    func didTapLogInButton()
}

class UserCredentials: UIView{
    
    // MARK: UI Elements
    private var titleLoginLabel: UILabel!
    private var emailTextField: UITextField!
    private var passwordTextField: UITextField!
    private var loginButton: UIButton!
    private var loginLabel: UILabel!
    private var registerbutton: UIButton!
    
    //MARK: Delegate
    weak var delegate: UserCredentialsDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        titleLoginLabel = UILabel()
        titleLoginLabel.text = "Login"
        titleLoginLabel.clipsToBounds = true
        titleLoginLabel.layer.masksToBounds = false
        titleLoginLabel.numberOfLines = 0
        titleLoginLabel.backgroundColor = .cyan
        
        emailTextField = UITextField()
        emailTextField.backgroundColor = .yellow
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = UITextField.BorderStyle.none
        emailTextField.keyboardType = UIKeyboardType.numberPad
        emailTextField.returnKeyType = UIReturnKeyType.done
        emailTextField.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        emailTextField.backgroundColor = .blue
        
        passwordTextField = UITextField()
        passwordTextField.backgroundColor = .cyan
        passwordTextField.placeholder = "Password"
        
        loginButton = UIButton()
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        loginButton.backgroundColor = .blue
        
        loginLabel = UILabel()
        loginLabel.text = "New to MoviesApp?"
        loginLabel.clipsToBounds = true
        loginLabel.layer.masksToBounds = false
        loginLabel.numberOfLines = 0
        loginButton.backgroundColor = .green
        
        registerbutton = UIButton()
        registerbutton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        registerbutton.backgroundColor = .red
        
        addSubview(titleLoginLabel)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(loginLabel)
        addSubview(registerbutton)
    }
    
    @objc func handleRegister() {
        delegate?.didTapRegisterButton()
    }
    
    @objc func handleLogin() {
        delegate?.didTapLogInButton()
    }
    
    func setupConstraints(){
        titleLoginLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(self).offset(5)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLoginLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(20)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(20)
        }
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.height.equalTo(30)
        }
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.width.equalTo(350)
            make.left.equalTo(self).offset(20)
        }
        registerbutton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.right.equalTo(-30)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
    }
}
