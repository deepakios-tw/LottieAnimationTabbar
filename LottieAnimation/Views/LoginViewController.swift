//
//  LoginViewController.swift
//  Coordinators
//
//  Created by Dr.Mac on 15/04/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var btnForgotPwd: UIButton!
    
    weak var router: NextSceneDismisser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [ btnBack, btnSignup, btnForgotPwd].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
    }
}

// MARK: Button Action
extension LoginViewController {
    @objc func buttonPressed(_ sender: UIButton) {
        switch  sender {
        case btnSignup:
            self.signupAction()
        case btnBack:
            self.backAction()
        case btnForgotPwd:
            self.forgotPwdAction()
        default:
            break
        }
    }
    
    private func signupAction() {
        self.router?.push(scene: .signup)
    }
    
    private func forgotPwdAction() {
        self.router?.push(scene: .forgot)
    }
    
    private func backAction() {
        self.router?.dismiss(controller: .login)
    }
}
