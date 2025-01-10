//
//  SignupViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation
import UIKit
final class SignupViewController: UIViewController {
    
    private let interactor: SignupBusinessLogic
    
    private lazy var nameTextField: UITextField = UITextField()
    private lazy var usernameTextField: UITextField = UITextField()
    private lazy var inputButton: UIButton = UIButton(type: .system)
    
    private var isNameInputValid: Bool = false
    private var isUsernameInputValid: Bool = false
    
    init(interactor: SignupBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem?.isEnabled = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        configureNameTextField()
        configureUsernameTextField()
        configureInputButton()
    }
    
    private func configureNameTextField() {
        view.addSubview(nameTextField)
        nameTextField.borderStyle = UITextField.BorderStyle.bezel
        nameTextField.placeholder = "Name"
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: nameTextField.frame.height))
        nameTextField.leftView = paddingView
        nameTextField.leftViewMode = .always
        nameTextField.delegate = self
        nameTextField.pinTop(view.safeAreaLayoutGuide.topAnchor, 60)
        nameTextField.pinCentreX(view)
        nameTextField.setHeight(40)
        nameTextField.setWidth(300)
    }
    
    private func configureUsernameTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.borderStyle = UITextField.BorderStyle.bezel
        usernameTextField.placeholder = "Username"
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: usernameTextField.frame.height))
        usernameTextField.leftView = paddingView
        usernameTextField.leftViewMode = .always
        usernameTextField.delegate = self
        usernameTextField.pinTop(nameTextField.bottomAnchor, 20)
        usernameTextField.pinCentreX(view)
        usernameTextField.setHeight(40)
        usernameTextField.setWidth(300)
    }
    
    private func configureInputButton() {
        view.addSubview(inputButton)
        inputButton.setTitle("Sign Up", for: .normal)
        inputButton.isEnabled = false
        inputButton.alpha = 0.5
        inputButton.setTitleColor(.white, for: .normal)
        inputButton.backgroundColor = .systemBlue
        inputButton.pinBottom(view.safeAreaLayoutGuide.bottomAnchor, 60)
        inputButton.pinCentreX(view)
        inputButton.addTarget(self, action: #selector(inputButtonPressed), for: .touchUpInside)
    }
    
    internal func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        switch(textField) {
        case nameTextField:
            let validator = SignupDataValidator()
            isNameInputValid = validator.validateName(text)
        case usernameTextField:
            let validator = SignupDataValidator()
            isUsernameInputValid = validator.validateUsername(text)
        default:
            break
        }
        updateAuthorizationButtonState()
    }
    
    private func updateAuthorizationButtonState() {
        inputButton.isEnabled = isNameInputValid && isUsernameInputValid
        inputButton.alpha = inputButton.isEnabled ? 1.0 : 0.5
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    private func inputButtonPressed() {
        interactor.sendSignupRequest(nameTextField.text!, usernameTextField.text!)
    }
}

extension SignupViewController: UITextFieldDelegate {
    
}
