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
        static let startMessengerButtonBottomAnchor: CGFloat = 60
        static let startMessengerButtonHeight: CGFloat = 40
        static let startMessengerButtonCornerRadius: CGFloat = 15
        static let startMessengerButtonTitle: String = "Press button to start conversation"
    }
    
    private lazy var startMessengerButton: UIButton = UIButton(type: .system)
    var onRouteToRegistrationScreen: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureStartMessengerButton()
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
        onRouteToRegistrationScreen?()
    }
}
