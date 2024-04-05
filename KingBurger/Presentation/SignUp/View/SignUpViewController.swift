//
//  SignUpViewController.swift
//  KingBurger
//
//  Created by Maxwell Farias on 08/08/23.
//

import Foundation
import UIKit

enum SignUpForm: Int {
    case name = 0x1
    case email = 0x2
    case password = 0x4
    case document = 0x8
    case dateOfBirth = 0x10
}

class SignUpViewController: UIViewController {
    let scroll: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.contentInsetAdjustmentBehavior = .never
        return sv
    }()
    
    let mainContainer: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let screenTitleLb: UILabel = {
        let lb = UILabel()
        lb.textColor = .label
        lb.text = "Sign Up"
        lb.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let formContainer: UIStackView = {
        let v = UIStackView()
        v.backgroundColor = .clear
        v.axis = .vertical
        v.spacing = 15.0
        v.distribution = .fillProportionally
        v.isLayoutMarginsRelativeArrangement = true
        v.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
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
        img.image = UIImage(named: "burgerSignUp")	
        img.setContentHuggingPriority(.defaultLow, for: .vertical)
        img.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var name: TextField = {
        let tf = TextField()
        tf.placeholder = "Enter your name"
        tf.delegate = self
        tf.tag = 1
        tf.error = "Name must be at least 3 characters"
        tf.failure = {text in
            return tf.text.count < 3
        }
        tf.bitmask = SignUpForm.name.rawValue
        tf.returnKeyType = .next
        return tf
    }()
    
    lazy var email: TextField = {
        let tf = TextField()
        tf.placeholder = "Enter your e-mail"
        tf.delegate = self
        tf.tag = 2
        tf.keyBoardType = .emailAddress
        tf.error = "Invalid e-mail"
        tf.failure = {text in
            return !tf.text.isEmail()
        }
        tf.bitmask = SignUpForm.email.rawValue
        tf.returnKeyType = .next
        return tf
    }()
    
    lazy var password: TextField = {
        let tf = TextField()
        tf.placeholder = "Enter your Password"
        tf.delegate = self
        tf.tag = 3
        tf.error = "Password must be at least 8 characters"
        tf.failure = { text in
            return tf.text.count < 8
        }
        tf.bitmask = SignUpForm.password.rawValue
        tf.isSecureTextEntry = true
        tf.returnKeyType = .next
        return tf
    }()
    
    lazy var document: TextField = {
        let tf = TextField()
        tf.delegate = self
        tf.tag = 4
        tf.error = "Invalid CPF"
        tf.placeholder = "Enter your CPF"
        tf.keyBoardType = .numberPad
        tf.failure = { text in
            return tf.text.count != 14
        }
        tf.maskField = Mask(mask: "###.###.###-##")
        tf.bitmask = SignUpForm.document.rawValue
        tf.returnKeyType = .next
        return tf
    }()
    
    lazy var dateOfBirth: TextField = {
        let tf = TextField()
        tf.placeholder = "Enter your date of birth"
        tf.error = "Date of birth must be mm/dd/yyyy"
        tf.delegate = self
        tf.tag = 5
        tf.failure = { text in
            let invalidCount = tf.text.count != 10
            let date = tf.text.toDate()
            let invalidDate = date == nil
            return invalidDate || invalidCount
        }
        tf.maskField = Mask(mask: "##/##/####")
        tf.keyBoardType = .numberPad
        tf.bitmask = SignUpForm.dateOfBirth.rawValue
        tf.returnKeyType = .done
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var send: LoadingButton = {
        let btn = LoadingButton()
        btn.title = "Enter"
        btn.titleColor = .white
        btn.backgroundColor = UIColor(named: "backgroundFeedPriceLb")
        btn.addTarget(self, action: #selector(sendDidTap))
        btn.enabledButton(isEnabled: false)
        return btn
    }()
    
    var bitmaskResult = 0
    
    var viewModel: SignUpViewModel?
    
    override func viewDidLoad() {
        applyViewCode()
        viewModel?.delegate = self
        view.backgroundColor = .systemBackground
        view.clipsToBounds = true
        
        configureKeyboard(handle: keyboardHandle)
        configureDismissKeyboard()
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
    
    @objc func sendDidTap (_ sende: UIButton) {
        viewModel?.send()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
}


extension SignUpViewController: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        view.addSubview(backgroundImg)
        view.addSubview(scroll)
        scroll.addSubview(mainContainer)
        mainContainer.addSubview(screenTitleLb)
        mainContainer.addSubview(formContainer)
        formContainer.addArrangedSubview(name)
        formContainer.addArrangedSubview(email)
        formContainer.addArrangedSubview(password)
        formContainer.addArrangedSubview(document)
        formContainer.addArrangedSubview(dateOfBirth)
        formContainer.addArrangedSubview(send)
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
            screenTitleLb.topAnchor.constraint(equalTo: mainContainer.topAnchor),
            
            formContainer.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor),
            formContainer.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -20),
            formContainer.topAnchor.constraint(equalTo: screenTitleLb.bottomAnchor, constant: 20),
            
            backgroundBurgerImg.topAnchor.constraint(greaterThanOrEqualTo: formContainer.bottomAnchor, constant: 20),
            backgroundBurgerImg.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: 80),
            backgroundBurgerImg.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor),
            
            backgroundBurgerImg.widthAnchor.constraint(equalTo: mainContainer.widthAnchor),
            backgroundBurgerImg.heightAnchor.constraint(equalTo: backgroundBurgerImg.widthAnchor, multiplier: 0.503),
            
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

extension SignUpViewController: SignUpViewModelDelegate {
    func viewModelDidChanged(state: SignUpState) {
        switch(state) {
        case .none:
            break
        case .loading:
            send.startLoading(true)
            break
        case .goToLogin:
            send.startLoading(false)
            let alert = UIAlertController(title: "Titulo", message: "Usuario cadastrado com sucesso!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                self.viewModel?.goToLogin()
            }))
            
            self.present(alert, animated: true)
            
            break
        case .error(let msg):
            send.startLoading(false)
            let alert = UIAlertController(title: "Titulo", message: msg, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            
            self.present(alert, animated: true)
            
            break
        }
    }
}

extension SignUpViewController: TextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .done {
            textField.endEditing(true)
        }
        
        let nextTag = textField.tag + 1
        let component = formContainer.findViewByTag(tag: nextTag) as? TextField
        if component != nil {
            component?.gainFocus()
        } else {
            textField.endEditing(true)
        }
        
        return false
    }
    
    func textFieldDidChanged(isValid: Bool, bitmask: Int, text: String) {
        if isValid {
            self.bitmaskResult = bitmaskResult | bitmask
        } else {
            self.bitmaskResult = bitmaskResult & ~bitmask
        }
        
        send.enabledButton(isEnabled:
                            (bitmaskResult & SignUpForm.name.rawValue != 0) &&
                           (bitmaskResult & SignUpForm.email.rawValue != 0) &&
                           (bitmaskResult & SignUpForm.password.rawValue != 0) &&
                           (bitmaskResult & SignUpForm.document.rawValue != 0) &&
                           (bitmaskResult & SignUpForm.dateOfBirth.rawValue != 0)
        )
        
        if bitmask == SignUpForm.name.rawValue {
            viewModel?.name = text
        }
        else if bitmask == SignUpForm.email.rawValue {
            viewModel?.email = text
        }
        else if bitmask == SignUpForm.password.rawValue {
            viewModel?.password = text
        }
        else if bitmask == SignUpForm.document.rawValue {
            viewModel?.document = text
        }
        else if bitmask == SignUpForm.dateOfBirth.rawValue {
            viewModel?.birthday = text
        }
    }
}
