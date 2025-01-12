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
        static let startMessengerButtonHorizontalAnchor: CGFloat = 20
        static let startMessengerButtonBottomAnchor: CGFloat = 30
        static let startMessengerButtonHeight: CGFloat = 40
        static let startMessengerButtonCornerRadius: CGFloat = 15
        static let startMessengerButtonTitle: String = "Press button to start conversation"
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
        configureGradientBackgroundLayer()
        configureStartMessengerLabel()
        configureStartMessengerButton()
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
        chakLabel.font = UIFont(name: "Micro5-Regular", size: 200)
        chakLabel.textColor = .black
        
        chatLabel.text = "Chat"
        chatLabel.textAlignment = .center
        chatLabel.font = UIFont(name: "Micro5-Regular", size: 200)
        chatLabel.textColor = .black
        
        view.addSubview(chakchatStackView)
        chakchatStackView.axis = .vertical
        chakchatStackView.alignment = .center
        chakchatStackView.spacing = -100
        chakchatStackView.pinCentre(view)
    }
    
    private func configureStartMessengerButton() {
        view.addSubview(startMessengerButton)
        startMessengerButton.pinHorizontal(view, Constants.startMessengerButtonHorizontalAnchor)
        startMessengerButton.pinBottom(view.safeAreaLayoutGuide.bottomAnchor, Constants.startMessengerButtonBottomAnchor)
        startMessengerButton.setHeight(Constants.startMessengerButtonHeight)
        startMessengerButton.layer.cornerRadius = Constants.startMessengerButtonCornerRadius
        startMessengerButton.setTitle(Constants.startMessengerButtonTitle, for: .normal)
        startMessengerButton.setTitleColor(.white, for: .normal)
        startMessengerButton.backgroundColor = .systemBlue
        startMessengerButton.addTarget(self, action: #selector(startMessengerButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func startMessengerButtonPressed() {
        onRouteToSendCodeScreen?(AppState.sendPhoneCode)
    }
}
