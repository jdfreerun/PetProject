//
//  ViewController.swift
//  PetProject
//
//  Created by Albert Fayzullin on 26.04.2022.
//
import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private lazy var loginInput = UITextField()
    private lazy var passInput = UITextField()
    private lazy var authButton = UIButton()
    private lazy var bottomView = UIView()
    private lazy var titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBlue
        
        view.addSubview(titleLabel)
        titleLabel.text = "Hello, User!"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(200)
        }
        
        view.addSubview(bottomView)
        bottomView.backgroundColor = UIColor.white
        bottomView.layer.cornerRadius = 36
        bottomView.snp.makeConstraints { make in
            make.size.equalToSuperview()
            make.top.equalTo(titleLabel).offset(100)
        }
        
        view.addSubview(loginInput)
        loginInput.autocorrectionType = .no
        loginInput.layer.borderWidth = 1
        loginInput.layer.borderColor = UIColor.lightGray.cgColor
        loginInput.layer.cornerRadius = 8
        loginInput.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: loginInput.frame.height))
        loginInput.leftViewMode = .always
        loginInput.placeholder = "Введите логин"
        loginInput.textContentType = .username
        loginInput.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 300, height: 50))
            make.top.equalTo(bottomView).offset(50)
            make.centerX.equalTo(self.view)
        }
        
        
        let showPassImg = UIImageView(frame: CGRect(x: 8.0, y: 12.0, width: 20.0, height: 20.0))
        let image = UIImage(named: "eye.fill")
        showPassImg.image = image
        showPassImg.contentMode = .scaleAspectFit
        let showPassView = UIView(frame: CGRect(x: 0, y: 0, width: 39, height: 40))
        showPassView.addSubview(showPassImg)
        
        view.addSubview(passInput)
        passInput.placeholder = "Введите пароль"
        passInput.layer.borderWidth = 1
        passInput.layer.borderColor = UIColor.lightGray.cgColor
        passInput.layer.cornerRadius = 8
        passInput.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: passInput.frame.height))
        passInput.leftViewMode = .always
        passInput.isSecureTextEntry = true
        passInput.snp.makeConstraints { make in
            make.size.equalTo(loginInput)
            make.top.equalTo(loginInput).offset(80)
            make.centerX.equalTo(self.view)
        }
        passInput.rightViewMode = .always
        passInput.rightView = showPassView
        passInput.returnKeyType = .done
        
        
        view.addSubview(authButton)
        authButton.backgroundColor = UIColor.systemBlue
        authButton.layer.cornerRadius = 10
        authButton.setTitle("Авторизоваться", for: .normal)
        authButton.snp.makeConstraints { make in
            make.size.equalTo(loginInput)
            make.top.equalTo(passInput).offset(80)
            make.centerX.equalTo(self.view)
        }
        authButton.alpha = 0.4
        authButton.isEnabled = false
        
        setup()
        
    }
//    func textFieldDidBeginEditing(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let text = (loginInput.text! as NSString).replacingCharacters(in: range, with: string)
//        if text.isEmpty {
//            authButton.alpha = 0.4
//            authButton.isEnabled = false
//        } else {
//            authButton.alpha = 1
//            authButton.isEnabled = true
//        }
//       return true
//
//      }
   
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setup() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
            let keyboardHide = keyboardFrame.cgRectValue.height
            let bottomSpace = self.view.frame.height - (authButton.frame.origin.y + authButton.frame.height)
            self.view.frame.origin.y = -(keyboardHide - bottomSpace + 10)
            print(keyboardFrame)
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
        print("Клавиатура пропала")
    }
    
}
