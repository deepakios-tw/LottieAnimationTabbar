//
//  SignupViewController.swift
//  Coordinators
//
//  Created by Dr.Mac on 15/04/22.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    weak var router: NextSceneDismisser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [ btnBack, btnLogin].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
    }
}

// MARK: Button Action
extension SignupViewController {
    @objc func buttonPressed(_ sender: UIButton) {
        switch  sender {
        case btnLogin:
            self.loginAction()
        case btnBack:
            self.backAction()
        default:
            break
        }
    }
    
    private func loginAction() {
        self.router?.push(scene: .login)
    }
    
    private func backAction() {
        self.router?.dismiss(controller: .signup)
    }
}
