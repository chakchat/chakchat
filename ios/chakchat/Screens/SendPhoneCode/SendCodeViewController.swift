//
//  RegistrationViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import UIKit
final class SendCodeViewController: UIViewController {
    
    enum Constants {
        static let inputNumberLabelText: String = "Input your phone number"
        static let inputNumberLabelFontSize: CGFloat = 16
        static let inputNumberLabelTopAnchor: CGFloat = 100
        
        static let inputNumberTextFieldPlaceholder: String = "Phone"
        static let inputNumberTextFieldTopAnchor: CGFloat = 50
        static let inputNumberTextFieldHeight: CGFloat = 40
        static let inputNumberTextFieldPaddingWidth: CGFloat = 10
        
        static let inputButtonText: String = "Send"
        static let inputButtonBottomAnchor: CGFloat = 40
    }
    
    private var interactor: SendCodeBusinessLogic
    private lazy var inputNumberLabel: UILabel = UILabel()
    private lazy var inputNumberTextField: UITextField = UITextField()
    private lazy var sendButton: UIButton = UIButton(type: .system)
    
    private var isPhoneNubmerInputValid: Bool = false
    
    init(interactor: SendCodeBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        configureInputNumberLabel()
        configureInputNumberTextField()
        configureInputButton()
    }
    
    private func configureInputNumberLabel() {
        view.addSubview(inputNumberLabel)
        inputNumberLabel.text = Constants.inputNumberLabelText
        inputNumberLabel.font = UIFont.systemFont(ofSize: Constants.inputNumberLabelFontSize)
        inputNumberLabel.pinTop(view.safeAreaLayoutGuide.topAnchor, Constants.inputNumberLabelTopAnchor)
        inputNumberLabel.pinCentreX(view)
        inputNumberLabel.numberOfLines = 1 // All text in one line
    }
    
    private func configureInputNumberTextField() {
        view.addSubview(inputNumberTextField)
        inputNumberTextField.placeholder = Constants.inputNumberTextFieldPlaceholder
        inputNumberTextField.pinTop(inputNumberLabel.bottomAnchor, Constants.inputNumberTextFieldTopAnchor)
        inputNumberTextField.setHeight(Constants.inputNumberTextFieldHeight)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.inputNumberTextFieldPaddingWidth, height: inputNumberTextField.frame.height))
        inputNumberTextField.leftView = paddingView
        inputNumberTextField.leftViewMode = .always
        inputNumberTextField.delegate = self
    }
    
    private func configureInputButton() {
        view.addSubview(sendButton)
        sendButton.setTitle(Constants.inputButtonText, for: .normal)
        sendButton.isEnabled = false // Button is disabled until correct data is entered in inputNumberTextField
        sendButton.alpha = 0.5
        sendButton.setTitleColor(.white, for: .normal)
        sendButton.backgroundColor = .systemBlue
        sendButton.pinCentreX(view)
        sendButton.pinBottom(view.safeAreaLayoutGuide.bottomAnchor, Constants.inputButtonBottomAnchor)
        sendButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
    }
    
    internal func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        switch(textField) {
        case inputNumberTextField:
            let validator = PhoneValidator()
            isPhoneNubmerInputValid = validator.validate(text)
        default:
            break
        }
        updateAuthorizationButtonState()
    }
    
    private func updateAuthorizationButtonState() {
        sendButton.isEnabled = isPhoneNubmerInputValid
        sendButton.alpha = sendButton.isEnabled ? 1.0 : 0.5
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    private func sendButtonPressed() {
        interactor.sendCodeRequest(
            SendCodeModels.SendCodeRequest(
                phone: inputNumberTextField.text!)
        )
    }
    
}

extension SendCodeViewController: UITextFieldDelegate {
    // hello world
}
