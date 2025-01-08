//
//  VerifyViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 08.01.2025.
//

import Foundation
import UIKit
final class VerifyViewController: UIViewController {
    
    enum Constants {
        static let inputLabelText: String = "Input code"
        static let inputLabelTopAnchor: CGFloat = 40
        
        static let inputTextFieldPlaceholder: String = "Code"
        static let inputTextFieldTopAnchor: CGFloat = 100
        static let inputTextFieldHeight: CGFloat = 40
        static let inputTextFieldWidth: CGFloat = 100
        static let inputTextFieldPaddingWidth: CGFloat = 10
        
        static let sendButtonText: String = "Send"
        static let sendButtonBottomAnchor: CGFloat = 40
    }
    
    private var interactor: VerifyBusinessLogic
    
    private lazy var inputLabel: UILabel = UILabel()
    private lazy var inputTextField: UITextField = UITextField()
    private lazy var sendButton: UIButton = UIButton(type: .system)
    
    private var isVerificationCodeInputValid: Bool = false
    
    init(interactor: VerifyBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        configureInputLabel()
        configureInputTextField()
        configureSendButton()
    }
    
    private func configureInputLabel() {
        view.addSubview(inputLabel)
        inputLabel.text = Constants.inputLabelText
        inputLabel.pinTop(view.safeAreaLayoutGuide.topAnchor, Constants.inputLabelTopAnchor)
        inputLabel.pinCentreX(view)
    }
    
    private func configureInputTextField() {
        view.addSubview(inputTextField)
        inputTextField.placeholder = Constants.inputTextFieldPlaceholder
        inputTextField.pinTop(inputLabel.bottomAnchor, Constants.inputTextFieldTopAnchor)
        inputTextField.setHeight(Constants.inputTextFieldHeight)
        inputTextField.setWidth(Constants.inputTextFieldWidth)
        inputTextField.pinCentreX(view)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.inputTextFieldPaddingWidth, height: inputTextField.frame.height))
        inputTextField.leftView = paddingView
        inputTextField.leftViewMode = .always
        inputTextField.delegate = self
    }
    
    private func configureSendButton() {
        view.addSubview(sendButton)
        sendButton.setTitle(Constants.sendButtonText, for: .normal)
        sendButton.isEnabled = false
        sendButton.alpha = 0.5
        sendButton.setTitleColor(.white, for: .normal)
        sendButton.backgroundColor = .systemBlue
        sendButton.pinCentreX(view)
        sendButton.pinBottom(view.safeAreaLayoutGuide.bottomAnchor, Constants.sendButtonBottomAnchor)
        sendButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
    }
    
    internal func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        switch(textField) {
        case inputTextField:
            let validator = VerificationCodeValidator()
            isVerificationCodeInputValid = validator.validate(text)
        default:
            break
        }
        updateAuthorizationButtonState()
    }
    
    private func updateAuthorizationButtonState() {
        sendButton.isEnabled = isVerificationCodeInputValid
        sendButton.alpha = sendButton.isEnabled ? 1.0 : 0.5
    }
    
    @objc
    private func sendButtonPressed() {
        interactor.sendVerificationRequest(inputTextField.text!)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension VerifyViewController: UITextFieldDelegate {
    
}
