//
//  SignUpView.swift
//  Movies
//
//  Created by Iskra Gjorgjievska on 29.5.23.
//

protocol SignUpViewDelegate: AnyObject {
    func didTaploginButton()
}

import Foundation
import UIKit
import SnapKit

class SignUpView: UIView{
    
    // MARK: UI Elements - Icons
    private var blurVisualEffectView: UIVisualEffectView!
    private var emailIconImage: UIImageView!
    private var passwordIconImage: UIImageView!
    private var firstNameIconImage: UIImageView!
    private var lastNameIconImage: UIImageView!
    private var dateOfBirthIconImage: UIImageView!
    
    // MARK: UI Elements
    private var signUpLabel: UILabel!
    private var registerWithEmailLabel: UILabel!
    private var emailTextField: UITextField!
    private var passwordTextField: UITextField!
    private var firstNameTextField: UITextField!
    private var lastNameTextField: UITextField!
    private var dateOfBirthTextField: UITextField!
    private var registerButton: UIButton!
    private var orGoBackToLabel: UILabel!
    private var loginButton: UIButton!
    private var datePicker = UIDatePicker()
    private var passwordHideIconButton: UIButton!
    
    //MARK: Delegate
    weak var delegate:SignUpViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupViews()
        setupConstraints()
        createDatepicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createToolBar() -> UIToolbar{
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        
        return toolbar
    }
    
    func createDatepicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "en")
        
        dateOfBirthTextField.textAlignment = .left
        dateOfBirthTextField.inputView = datePicker
        dateOfBirthTextField.inputAccessoryView = createToolBar()
    }
    
    @objc func donePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MMMM.yyyy"
        dateFormatter.locale = Locale(identifier: "en")
        
        self.dateOfBirthTextField.text = dateFormatter.string(from: datePicker.date)
        self.endEditing(true)
    }
    
    func setupViews(){
        
        let blurView = UIBlurEffect(style: .light)
        blurVisualEffectView = UIVisualEffectView(effect: blurView)
        blurVisualEffectView.layer.borderColor = UIColor.gray.cgColor
        blurVisualEffectView.layer.borderWidth = 1.0
        blurVisualEffectView.layer.cornerRadius = 10.0
        blurVisualEffectView.layer.masksToBounds = true
        
        emailIconImage = UIImageView()
        emailIconImage.image = UIImage(named: "mailIcon")
        
        passwordIconImage = UIImageView()
        passwordIconImage.image = UIImage(named: "lockIcon")
        
        firstNameIconImage = UIImageView()
        firstNameIconImage.image = UIImage(named: "UserIcon")
        
        lastNameIconImage = UIImageView()
        lastNameIconImage.image = UIImage(named: "UserIcon")
        
        dateOfBirthIconImage = UIImageView()
        dateOfBirthIconImage.image = UIImage(named: "calendar")
        
        signUpLabel = UILabel()
        signUpLabel.text = "Sign up"
        signUpLabel.clipsToBounds = true
        signUpLabel.layer.masksToBounds = false
        signUpLabel.numberOfLines = 0
        signUpLabel.textColor = UIColor.white
        signUpLabel.font = UIFont.boldSystemFont(ofSize: 25)
        signUpLabel.textAlignment = .left
        
        registerWithEmailLabel = UILabel()
        registerWithEmailLabel.text = "Register with email.."
        registerWithEmailLabel.font = UIFont.systemFont(ofSize: 20)
        registerWithEmailLabel.clipsToBounds = true
        registerWithEmailLabel.textColor = .white
        registerWithEmailLabel.layer.masksToBounds = false
        registerWithEmailLabel.textAlignment = .center
        
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = UITextField.BorderStyle.none
        emailTextField.keyboardType = UIKeyboardType.numberPad
        emailTextField.returnKeyType = UIReturnKeyType.done
        emailTextField.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        emailTextField.font = UIFont.systemFont(ofSize: 20)
        emailTextField.addLine(position: .bottom, color: .darkGray, width: 1.0)
        
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.font = UIFont.systemFont(ofSize: 20)
        passwordTextField.addLine(position: .bottom, color: .darkGray, width: 1.0)
        passwordTextField.isSecureTextEntry = true
        
        passwordHideIconButton = UIButton()
        passwordHideIconButton.setImage(UIImage(named: "passIcon"), for: .normal)
        passwordHideIconButton.addTarget(self, action: #selector(passwordHideShowIcon), for: .touchUpInside)
        
        firstNameTextField = UITextField()
        firstNameTextField.placeholder = "First Name"
        firstNameTextField.borderStyle = UITextField.BorderStyle.none
        firstNameTextField.keyboardType = UIKeyboardType.numberPad
        firstNameTextField.returnKeyType = UIReturnKeyType.done
        firstNameTextField.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        firstNameTextField.font = UIFont.systemFont(ofSize: 20)
        firstNameTextField.addLine(position: .bottom, color: .darkGray, width: 1.0)
        
        lastNameTextField = UITextField()
        lastNameTextField.placeholder = "Last Name"
        lastNameTextField.borderStyle = UITextField.BorderStyle.none
        lastNameTextField.keyboardType = UIKeyboardType.numberPad
        lastNameTextField.returnKeyType = UIReturnKeyType.done
        lastNameTextField.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        lastNameTextField.font = UIFont.systemFont(ofSize: 20)
        lastNameTextField.addLine(position: .bottom, color: .darkGray, width: 1.0)
        
        dateOfBirthTextField = UITextField()
        dateOfBirthTextField.placeholder = "Date of birth"
        dateOfBirthTextField.font = UIFont.systemFont(ofSize: 20)
        dateOfBirthTextField.addLine(position: .bottom, color: .darkGray, width: 1.0)
        
        registerButton = UIButton()
        registerButton.backgroundColor = .blue
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.layer.cornerRadius = 7.0
        
        orGoBackToLabel = UILabel()
        orGoBackToLabel.text = "Or go back to"
        orGoBackToLabel.clipsToBounds = true
        orGoBackToLabel.layer.masksToBounds = false
        orGoBackToLabel.numberOfLines = 0
        orGoBackToLabel.backgroundColor = .clear
        orGoBackToLabel.textColor = .white
        
        loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.blue, for: .normal)
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        
        addSubview(blurVisualEffectView)
        
        addSubview(signUpLabel)
        addSubview(registerWithEmailLabel)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(firstNameTextField)
        addSubview(lastNameTextField)
        addSubview(dateOfBirthTextField)
        addSubview(registerButton)
        addSubview(orGoBackToLabel)
        addSubview(loginButton)
        
        addSubview(emailIconImage)
        addSubview(passwordIconImage)
        addSubview(firstNameIconImage)
        addSubview(lastNameIconImage)
        addSubview(dateOfBirthIconImage)
        addSubview(passwordHideIconButton)
        
        bringSubviewToFront(signUpLabel)
        bringSubviewToFront(registerWithEmailLabel)
        bringSubviewToFront(emailTextField)
        bringSubviewToFront(passwordTextField)
        bringSubviewToFront(firstNameTextField)
        bringSubviewToFront(lastNameTextField)
        bringSubviewToFront(dateOfBirthTextField)
        bringSubviewToFront(registerButton)
        bringSubviewToFront(orGoBackToLabel)
        bringSubviewToFront(loginButton)
        
        bringSubviewToFront(emailIconImage)
        bringSubviewToFront(passwordIconImage)
        bringSubviewToFront(firstNameIconImage)
        bringSubviewToFront(lastNameIconImage)
        bringSubviewToFront(dateOfBirthIconImage)
        bringSubviewToFront(passwordHideIconButton)
    }
    
    @objc func handleLogin() {
        delegate?.didTaploginButton()
    }
    @objc func passwordHideShowIcon(){
        if passwordTextField.isSecureTextEntry{
            passwordTextField.isSecureTextEntry = false
        }else{
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    func setupConstraints(){
        blurVisualEffectView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(15)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
        }
        
        registerWithEmailLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        emailIconImage.snp.makeConstraints { make in
            make.top.equalTo(registerWithEmailLabel.snp.bottom).offset(25)
            make.left.equalTo(self).offset(10)
            make.height.width.equalTo(25)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailIconImage)
            make.left.equalTo(emailIconImage.snp.right).offset(5)
            make.right.equalTo(self).offset(-10)
        }
        
        passwordIconImage.snp.makeConstraints { make in
            make.top.equalTo(emailIconImage.snp.bottom).offset(20)
            make.left.equalTo(self).offset(10)
            make.height.width.equalTo(25)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordIconImage)
            make.left.equalTo(passwordIconImage.snp.right).offset(5)
            make.right.equalTo(self).offset(-10)
        }
        
        passwordHideIconButton.snp.makeConstraints { make in
            make.top.equalTo(passwordIconImage)
            make.right.equalTo(self).offset(-20)
            make.height.width.equalTo(20)
        }
        
        firstNameIconImage.snp.makeConstraints { make in
            make.top.equalTo(passwordIconImage.snp.bottom).offset(20)
            make.left.equalTo(self).offset(10)
            make.height.width.equalTo(25)
        }
        
        firstNameTextField.snp.makeConstraints { make in
            make.top.equalTo(firstNameIconImage)
            make.left.equalTo(firstNameIconImage.snp.right).offset(5)
            make.right.equalTo(self).offset(-10)
        }
        
        lastNameIconImage.snp.makeConstraints { make in
            make.top.equalTo(firstNameIconImage.snp.bottom).offset(20)
            make.left.equalTo(self).offset(10)
            make.height.width.equalTo(25)
        }
        
        lastNameTextField.snp.makeConstraints { make in
            make.top.equalTo(lastNameIconImage)
            make.left.equalTo(lastNameIconImage.snp.right).offset(5)
            make.right.equalTo(self).offset(-10)
        }
        
        dateOfBirthIconImage.snp.makeConstraints { make in
            make.top.equalTo(lastNameIconImage.snp.bottom).offset(20)
            make.left.equalTo(self).offset(10)
            make.height.width.equalTo(25)
        }
        
        dateOfBirthTextField.snp.makeConstraints { make in
            make.top.equalTo(dateOfBirthIconImage)
            make.left.equalTo(dateOfBirthIconImage.snp.right).offset(5)
            make.right.equalTo(self).offset(-10)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(dateOfBirthTextField.snp.bottom).offset(20)
            make.height.equalTo(40)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
        }
        
        orGoBackToLabel.snp.makeConstraints { make in
            make.top.equalTo(registerButton.snp.bottom).offset(15)
            make.left.equalTo(self).offset(120)
        }
        
        loginButton.snp.makeConstraints { make in
            make.centerY.equalTo(orGoBackToLabel)
            make.top.equalTo(registerButton.snp.bottom).offset(15)
            make.left.equalTo(orGoBackToLabel.snp.right).offset(7)
        }
    }
}

