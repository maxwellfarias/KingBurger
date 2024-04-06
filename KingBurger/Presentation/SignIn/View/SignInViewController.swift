//
//  ViewController.swift
//  KingBurger
//
//  Created by Maxwell Farias on 08/08/23.
//

import UIKit
//The decimal standard could be used, but when working with large numbers (which is not the case) it is easier to use hexadecimal.
enum SignInForm: Int {
    case email = 0x1
    case password = 0x2
}

class SignInViewController: UIViewController {
    
    private let scroll: UIScrollView = {
        let sv = UIScrollView()
        sv.bounces = true
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let mainContainer: UIView = {
        let v = UIView()
        v.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        v.layer.cornerRadius = 15
        v.clipsToBounds = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let backgroundImg: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.image = UIImage(named: "signInBgImg")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let backgroundBurgerImg: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = UIImage(named: "backgroundBurgerImg")
        img.setContentHuggingPriority(.defaultLow, for: .vertical)
        img.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let screenTitleLb: UILabel = {
        let lb = UILabel()
        lb.textColor = .label
        lb.text = "Sign In"
        lb.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var emailTf: KBTextField = {
        let tf = KBTextField()
        tf.placeholder = "Enter your e-mail"
        tf.error = "Invalid e-mail"
        tf.returnKeyType = .next
        tf.failure = { text in
            !tf.text.isEmail()
        }
        tf.delegate = self
        tf.bitmask = SignInForm.email.rawValue
        tf.keyBoardType = .emailAddress
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var passwordTf: KBTextField = {
        let tf = KBTextField()
        tf.placeholder = "Enter your password"
        tf.error = "invalid password"
        tf.returnKeyType = .done
        tf.failure = {text in
            return tf.text.count <= 5
        }
        tf.bitmask = 2
        tf.isSecureTextEntry = true
        tf.bitmask = SignInForm.password.rawValue
        tf.delegate = self
        return tf
    }()
    
    let checkbox: UIButton = {
        let checkbox = UIButton(type: .system)
        checkbox.setImage(UIImage(systemName: "checkmark.square")!, for: .normal)
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        return checkbox
    }()
    
    let rememberMeLb: UILabel = {
        let lb = UILabel()
        lb.text = "Remember me"
        lb.textColor = .systemGray
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let forgotPasswordBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        btn.setTitle("Forgot password", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var loginBtn: KBLoadingButton = {
        let btn = KBLoadingButton()
        btn.title = "LOGIN"
        btn.backgroundColor = UIColor(named: "backgroundFeedPriceLb")
        btn.layer.cornerRadius = 10
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(sendDidTap))
        btn.enabledButton(isEnabled:false)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let divView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .systemGray3
        return v
    }()
    
    let divLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Or"
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.backgroundColor = KingBurgerColor.signInBg
        lb.textColor = .systemGray
        lb.layer.zPosition = 2
        return lb
    }()
    
    let appleLoginBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle(" APPLE", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        btn.backgroundColor = .darkGray
        btn.titleLabel?.tintColor = .white
        btn.layer.cornerRadius = 10
        btn.setImage(UIImage(named: "appleIcon") , for: .normal)
        btn.contentEdgeInsets = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let googleLoginBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle(" GOOGLE", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        btn.backgroundColor = .darkGray
        btn.titleLabel?.tintColor = .white
        btn.setImage(UIImage(named: "googleIcon") , for: .normal)
        btn.layer.cornerRadius = 10
        btn.contentEdgeInsets = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let signUpLb: UILabel = {
        let lb = UILabel()
        lb.text = "Don't have an account?"
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.backgroundColor = .clear
        lb.textColor = .systemGray
        return lb
    }()
    
    let signUpBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Sign Up", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        btn.addTarget(self, action: #selector(registerDidTap), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var bitmaskResult = 0
    
    var viewModel: SignInViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyViewCode()
        view.backgroundColor = .systemBackground
        
        configureKeyboard(handle: keyboardHandle)
        configureDismissKeyboard()
        navigationController?.isNavigationBarHidden = true
    }
    
    lazy var keyboardHandle = KeyboardHandle { visible, height in
        if (!visible) {
            self.scroll.contentInset = .zero
            self.scroll.scrollIndicatorInsets = .zero
        } else {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: height + 40, right: 0.0)
            self.scroll.contentInset = contentInsets
            self.scroll.scrollIndicatorInsets = contentInsets
        }
    }
    
    @objc func sendDidTap (_ sender: UIButton) {
        viewModel?.send()
    }
    
    @objc func registerDidTap (_ sender: UIButton) {
        viewModel?.goToSignUp()
    }
}

extension SignInViewController: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        view.addSubview(backgroundImg)
        view.addSubview(scroll)
        scroll.addSubview(mainContainer)
        mainContainer.addSubview(screenTitleLb)
        mainContainer.addSubview(emailTf)
        mainContainer.addSubview(passwordTf)
        mainContainer.addSubview(checkbox)
        mainContainer.addSubview(rememberMeLb)
        mainContainer.addSubview(forgotPasswordBtn)
        mainContainer.addSubview(loginBtn)
        mainContainer.addSubview(divView)
        mainContainer.addSubview(divLabel)
        mainContainer.addSubview(appleLoginBtn)
        mainContainer.addSubview(googleLoginBtn)
        mainContainer.addSubview(signUpLb)
        mainContainer.addSubview(signUpBtn)
        mainContainer.addSubview(backgroundBurgerImg)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImg.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImg.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImg.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImg.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scroll.topAnchor.constraint(equalTo: view.safeTopAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            screenTitleLb.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 20),
            screenTitleLb.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor),
            screenTitleLb.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: 20),
            
            emailTf.topAnchor.constraint(equalTo: screenTitleLb.bottomAnchor, constant: 20),
            emailTf.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -20),
            emailTf.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 20),
            
            passwordTf.topAnchor.constraint(equalTo: emailTf.bottomAnchor, constant: 20),
            passwordTf.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 20),
            passwordTf.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -20),
            
            checkbox.topAnchor.constraint(equalTo: passwordTf.bottomAnchor, constant: 20),
            checkbox.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 20),
            
            rememberMeLb.centerYAnchor.constraint(equalTo: checkbox.centerYAnchor),
            rememberMeLb.leadingAnchor.constraint(equalTo: checkbox.trailingAnchor, constant: 10),
            
            forgotPasswordBtn.centerYAnchor.constraint(equalTo: rememberMeLb.centerYAnchor),
            forgotPasswordBtn.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -20),
            
            loginBtn.topAnchor.constraint(equalTo: checkbox.bottomAnchor, constant: 20),
            loginBtn.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 20),
            loginBtn.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -20),
            
            divView.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 20),
            divView.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -20),
            divView.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 30),
            divView.heightAnchor.constraint(equalToConstant: 1),
            
            divLabel.centerYAnchor.constraint(equalTo: divView.centerYAnchor),
            divLabel.centerXAnchor.constraint(equalTo: divView.centerXAnchor),
            divLabel.widthAnchor.constraint(equalToConstant: 40),
            
            appleLoginBtn.topAnchor.constraint(equalTo: divLabel.bottomAnchor, constant: 20),
            appleLoginBtn.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 20),
            appleLoginBtn.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 20),
            appleLoginBtn.trailingAnchor.constraint(equalTo: mainContainer.centerXAnchor, constant: -5),
            
            googleLoginBtn.topAnchor.constraint(equalTo: divLabel.bottomAnchor, constant: 20),
            googleLoginBtn.leadingAnchor.constraint(equalTo: appleLoginBtn.trailingAnchor, constant: 10),
            googleLoginBtn.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -20),
            
            signUpLb.topAnchor.constraint(equalTo: appleLoginBtn.bottomAnchor, constant: 20),
            signUpLb.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor, constant: -35),
            
            signUpBtn.centerYAnchor.constraint(equalTo: signUpLb.centerYAnchor),
            signUpBtn.leadingAnchor.constraint(equalTo: signUpLb.trailingAnchor, constant: 10),
            
            backgroundBurgerImg.topAnchor.constraint(greaterThanOrEqualTo: signUpLb.bottomAnchor, constant: 20),
            backgroundBurgerImg.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor),
            backgroundBurgerImg.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor),
            backgroundBurgerImg.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor),
            backgroundBurgerImg.heightAnchor.constraint(equalTo: backgroundBurgerImg.widthAnchor, multiplier: 0.4869)
        ])
        
        let mainContainerHeightConstraint = mainContainer.heightAnchor.constraint(equalTo: scroll.heightAnchor)
        mainContainerHeightConstraint.isActive = true
        mainContainerHeightConstraint.priority = .defaultLow
        NSLayoutConstraint.activate([
            mainContainer.widthAnchor.constraint(equalTo: scroll.widthAnchor),
            mainContainer.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            mainContainer.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            mainContainer.topAnchor.constraint(equalTo: scroll.topAnchor),
            mainContainer.bottomAnchor.constraint(equalTo: scroll.bottomAnchor)
        ])
    }
}

extension SignInViewController: SignInViewModelDelegate {
    func viewModelDidChanged(state: SignInState) {
        switch state {
        case .none:
            break
        case .loading:
            loginBtn.startLoading(true)
        case .goTohome:
            loginBtn.startLoading(false)
            viewModel?.goToHome()
            
        case .error(let msg):
            loginBtn.startLoading(false)
            let alert = UIAlertController(title: "KingBurguer", message: msg, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            
            self.present(alert, animated: true)
        }
    }
}

extension SignInViewController: TextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .next {
            passwordTf.gainFocus()
        } else {
            view.endEditing(true)
        }
        return true
    }
    
    func textFieldDidChanged(isValid: Bool, bitmask: Int, text: String) {
        if isValid {
            self.bitmaskResult = self.bitmaskResult | bitmask
            
        } else {
            self.bitmaskResult =  self.bitmaskResult & ~bitmask
        }
        loginBtn.enabledButton(isEnabled: (SignInForm.email.rawValue & self.bitmaskResult != 0) && (SignInForm.password.rawValue & self.bitmaskResult != 0))
        
        if bitmask == SignInForm.email.rawValue {
            viewModel?.username = text
        }
        else if bitmask == SignInForm.password.rawValue {
            viewModel?.password = text
        }
    }
}
