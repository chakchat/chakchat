//
//  StartViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import UIKit
final class StartViewController: UIViewController {
    
    enum Constants {
        static let chakchatFont: UIFont = UIFont(name: "Micro5-Regular", size: 200)!
    }
    
    private lazy var startMessengerButton: UIButton = UIButton(type: .system)
    private lazy var chakLabel: UILabel = UILabel()
    private lazy var chatLabel: UILabel = UILabel()
    private lazy var chakchatStackView = UIStackView(arrangedSubviews: [chakLabel, chatLabel])
    private lazy var gradientBackgroundLayer: CAGradientLayer = CAGradientLayer()
    var onRouteToSendCodeScreen: ((AppState) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        configureGradientBackgroundLayer()
        configureStartMessengerLabel()
    }
    
    private func configureGradientBackgroundLayer() {
        gradientBackgroundLayer.colors = [
            UIColor.orange.cgColor,
            UIColor.yellow.cgColor,
            UIColor.orange.cgColor
        ]
        gradientBackgroundLayer.locations = [0.0, 0.5, 1.0]
        gradientBackgroundLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientBackgroundLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientBackgroundLayer.frame = view.bounds
        view.layer.insertSublayer(gradientBackgroundLayer, at: 0)
    }
    
    private func configureStartMessengerLabel() {
        view.addSubview(chakLabel)
        view.addSubview(chatLabel)
        chakLabel.text = "Chak"
        chakLabel.textAlignment = .center
        chakLabel.font = Constants.chakchatFont
        chakLabel.textColor = .black
        
        chatLabel.text = "Chat"
        chatLabel.textAlignment = .center
        chatLabel.font = Constants.chakchatFont
        chatLabel.textColor = .black
        
        view.addSubview(chakchatStackView)
        chakchatStackView.axis = .vertical
        chakchatStackView.alignment = .center
        chakchatStackView.spacing = -100
        chakchatStackView.pinCentre(view)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
        onRouteToSendCodeScreen?(AppState.sendPhoneCode)
    }
}
