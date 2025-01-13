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
        static let chakchatStackViewTopAnchor: CGFloat = 40
        
        static let chakLabelText: String = "Chak"
        static let chatLabelText: String = "Chat"
        
        static let chakchatFont: UIFont = UIFont(name: "Micro5-Regular", size: 150)!
        static let inputPhoneFont: UIFont = UIFont(name: "RobotoMono-Regular", size: 28)!
        
        static let chakchatStackViewSpacing: CGFloat = -50
        static let inputNumberLabelFontSize: CGFloat = 16
        static let inputNumberLabelTopAnchor: CGFloat = 100
        
        static let inputNumberTextFieldPlaceholder: String = "+7 000 000 0000"
        static let inputNumberTextFieldTopAnchor: CGFloat = 50
        static let inputNumberTextFieldHeight: CGFloat = 60
        static let inputNumberTextFieldWidth: CGFloat = 300
        static let inputNumberTextFieldPaddingWidth: CGFloat = 10
        
        static let inputButtonText: String = "Enter"
        static let inputButtonHeight: CGFloat = 50
        static let inputButtonWidth: CGFloat = 200
        static let inputButtonFont: UIFont = UIFont.systemFont(ofSize: 26, weight: .bold)
        static let inputButtonTopAnchor: CGFloat = 40
        static let inputButtonGradientColor: [CGColor] = [UIColor.yellow.cgColor, UIColor.orange.cgColor]
        
        static let inputButtonGradientStartPoint: CGPoint = CGPoint(x: 0.0, y: 0.5)
        static let inputButtonGradientEndPoint: CGPoint = CGPoint(x: 1, y: 0.5)
        static let inputButtonGradientCornerRadius: CGFloat = 25
        
    }
    
    private var interactor: SendCodeBusinessLogic
    private lazy var chakLabel: UILabel = UILabel()
    private lazy var chatLabel: UILabel = UILabel()
    private lazy var chakchatStackView = UIStackView(arrangedSubviews: [chakLabel, chatLabel])
    private lazy var inputNumberTextField: PhoneNumberTextField = PhoneNumberTextField()
    private lazy var sendButton: UIButton = UIButton(type: .system)
    private lazy var sendButtonGradientLayer: CAGradientLayer = CAGradientLayer()
    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Updating the size of the gradient layer if the button has changed its size
        sendButtonGradientLayer.frame = sendButton.bounds
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        // I can tap everywhere for didEndEditing
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        self.navigationItem.hidesBackButton = true
        configureChakChatStackView()
        configureInputNumberTextField()
        configureInputButton()
    }
    
    private func configureChakChatStackView() {
        view.addSubview(chakLabel)
        view.addSubview(chatLabel)
        chakLabel.text = Constants.chakLabelText
        chakLabel.textAlignment = .center
        chakLabel.font = Constants.chakchatFont
        chakLabel.textColor = .black
        
        chatLabel.text = Constants.chatLabelText
        chatLabel.textAlignment = .center
        chatLabel.font = Constants.chakchatFont
        chatLabel.textColor = .black
        
        view.addSubview(chakchatStackView)
        chakchatStackView.axis = .vertical
        chakchatStackView.alignment = .center
        chakchatStackView.spacing = Constants.chakchatStackViewSpacing
        chakchatStackView.pinTop(view.safeAreaLayoutGuide.topAnchor, Constants.chakchatStackViewTopAnchor)
        chakchatStackView.pinCentreX(view)
    }
    
    private func configureInputNumberTextField() {
        view.addSubview(inputNumberTextField)
        inputNumberTextField.placeholder = Constants.inputNumberTextFieldPlaceholder
        inputNumberTextField.pinTop(chakchatStackView.bottomAnchor, Constants.inputNumberTextFieldTopAnchor)
        inputNumberTextField.setHeight(Constants.inputNumberTextFieldHeight)
        inputNumberTextField.setWidth(Constants.inputNumberTextFieldWidth)
        inputNumberTextField.pinCentreX(view)
        inputNumberTextField.keyboardType = .numberPad
        inputNumberTextField.borderStyle = .roundedRect
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.inputNumberTextFieldPaddingWidth, height: inputNumberTextField.frame.height))
        inputNumberTextField.leftView = paddingView
        inputNumberTextField.leftViewMode = .always
        inputNumberTextField.delegate = self
    }
    
    private func configureInputButton() {
        view.addSubview(sendButton)
        sendButton.setTitle(Constants.inputButtonText, for: .normal)
        sendButton.setTitleColor(.white, for: .normal)
        sendButton.titleLabel?.font = Constants.inputButtonFont
        sendButton.pinCentreX(view)
        sendButton.pinTop(inputNumberTextField.bottomAnchor, Constants.inputButtonTopAnchor)
        sendButton.setHeight(Constants.inputButtonHeight)
        sendButton.setWidth(Constants.inputButtonWidth)
        
        sendButtonGradientLayer.colors = Constants.inputButtonGradientColor
        sendButtonGradientLayer.startPoint = Constants.inputButtonGradientStartPoint
        sendButtonGradientLayer.endPoint = Constants.inputButtonGradientEndPoint
        sendButtonGradientLayer.cornerRadius = Constants.inputButtonGradientCornerRadius
        
        sendButton.layer.insertSublayer(sendButtonGradientLayer, at: 0)
        sendButtonGradientLayer.frame = sendButton.bounds
        
        sendButton.layoutIfNeeded()
        
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
    }

    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
        print("Touch")
    }
    
    @objc
    private func sendButtonPressed() {
        let cleanedPhone = inputNumberTextField.text!.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)

        if isPhoneNubmerInputValid {
            interactor.sendCodeRequest(
                SendCodeModels.SendCodeRequest(
                    phone: cleanedPhone)
            )
        } else {
            print("Input correct phone number")
        }
    }
}

extension SendCodeViewController: UITextFieldDelegate {
    // hello world
}

class PhoneNumberTextField: UITextField, UITextFieldDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.keyboardType = .numberPad
        self.text = "+7"
        self.delegate = self
        self.font = SendCodeViewController.Constants.inputPhoneFont
        self.addTarget(self, action: #selector(formatPhoneNumber), for: .editingChanged)
    }
    
    @objc private func formatPhoneNumber() {
        guard let text = self.text else { return }
        
        let rawNumber = text.replacingOccurrences(of: "\\D", with: "", options: .regularExpression)
        
        guard rawNumber.hasPrefix("7") else {
            self.text = "+7"
            return
        }

        var formattedNumber = "+7"
        
        if rawNumber.count > 1 {
            formattedNumber += "("
            let startIndex = rawNumber.index(rawNumber.startIndex, offsetBy: 1)
            let endIndex = rawNumber.index(startIndex, offsetBy: min(3, rawNumber.count - 1))
            formattedNumber += rawNumber[startIndex..<endIndex]
        }
        if rawNumber.count > 4 {
            formattedNumber += ")"
            let startIndex = rawNumber.index(rawNumber.startIndex, offsetBy: 4)
            let endIndex = rawNumber.index(startIndex, offsetBy: min(3, rawNumber.count - 4))
            formattedNumber += rawNumber[startIndex..<endIndex]
        }
        if rawNumber.count > 7 {
            formattedNumber += "-"
            let startIndex = rawNumber.index(rawNumber.startIndex, offsetBy: 7)
            let endIndex = rawNumber.index(startIndex, offsetBy: min(2, rawNumber.count - 7))
            formattedNumber += rawNumber[startIndex..<endIndex]
        }
        if rawNumber.count > 9 {
            formattedNumber += "-"
            let startIndex = rawNumber.index(rawNumber.startIndex, offsetBy: 9)
            let endIndex = rawNumber.index(startIndex, offsetBy: min(2, rawNumber.count - 9))
            formattedNumber += rawNumber[startIndex..<endIndex]
        }
        
        self.text = formattedNumber
    }
    

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        _ = textField.text ?? ""
        if range.location < 4 {
            return false
        }
        return true
    }
}

