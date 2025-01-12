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
        
        static let customFont: UIFont = UIFont(name: "Micro5-Regular", size: 150)!
        
        static let chakchatStackViewSpacing: CGFloat = -50
        static let inputNumberLabelFontSize: CGFloat = 16
        static let inputNumberLabelTopAnchor: CGFloat = 100
        
        static let inputNumberTextFieldPlaceholder: String = "Phone"
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
    private lazy var inputNumberTextField: UITextField = UITextField()
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
        configureChakChatStackView()
        configureInputNumberTextField()
        configureInputButton()
    }
    
    private func configureChakChatStackView() {
        view.addSubview(chakLabel)
        view.addSubview(chatLabel)
        chakLabel.text = Constants.chakLabelText
        chakLabel.textAlignment = .center
        chakLabel.font = Constants.customFont
        chakLabel.textColor = .black
        
        chatLabel.text = Constants.chatLabelText
        chatLabel.textAlignment = .center
        chatLabel.font = Constants.customFont
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
    }
    
    @objc
    private func sendButtonPressed() {
        if isPhoneNubmerInputValid {
            interactor.sendCodeRequest(
                SendCodeModels.SendCodeRequest(
                    phone: inputNumberTextField.text!)
            )
        } else {
            print("Input correct phone number")
        }
    }
}

extension SendCodeViewController: UITextFieldDelegate {
    // hello world
}
