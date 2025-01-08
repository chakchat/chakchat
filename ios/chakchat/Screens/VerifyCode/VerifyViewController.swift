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
    }
    
    private var interactor: VerifyBusinessLogic
    
    private lazy var inputLabel: UILabel = UILabel()
    
    init(interactor: VerifyBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configureUI() {
        
    }
    
    private func configureTestLabel() {
        view.addSubview(inputLabel)
        inputLabel.text = Constants.inputLabelText
    }
}
