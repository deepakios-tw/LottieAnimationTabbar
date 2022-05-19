//
//  ViewController.swift
//  Coordinators
//
//  Created by Dr.Mac on 14/04/22.
//

import UIKit

class WelcomeViewController: UIViewController {

  @IBOutlet weak var btnLogin: UIButton!
  @IBOutlet weak var btnSignup: UIButton!
  @IBOutlet weak var btnTabbar: UIButton!

  weak var router: NextSceneDismisser?

  override func viewDidLoad() {
    super.viewDidLoad()
    [ btnLogin, btnSignup, btnTabbar].forEach {
        $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
    }
  }
}

// MARK: Button Action
extension WelcomeViewController {
    @objc func buttonPressed(_ sender: UIButton) {
        switch  sender {
        case btnSignup:
            self.signupAction()
        case btnLogin:
            self.loginAction()
        case btnTabbar:
            self.tabbarAction()
        default:
            break
        }
    }

    private func signupAction() {
        self.router?.push(scene: .signup)
    }

    private func loginAction() {
        self.router?.push(scene: .login)
    }
    
    private func tabbarAction() {
        self.router?.push(scene: .tabbar)
    }
}
