//
//  VerifyInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 08.01.2025.
//

import Foundation
import UIKit
final class VerifyInteractor: VerifyBusinessLogic {
    
    private var presentor: VerifyPresentationLogic
    private var worker: VerifyWorkerLogic
    
    init(presentor: VerifyPresentationLogic, worker: VerifyWorkerLogic) {
        self.presentor = presentor
        self.worker = worker
    }
    
}
