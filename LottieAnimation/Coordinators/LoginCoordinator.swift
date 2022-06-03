//
//  LoginCoordinator.swift
//  Coordinators
//
//  Created by Dr.Mac on 14/04/22.
//

import Foundation

final class LoginCoordinator: Coordinator<Scenes> {
    
    weak var delegate: CoordinatorDimisser?
    let controller: LoginViewController = LoginViewController.from(from: .main, with: .login)
    let forgot: ForgotPasswordViewController = ForgotPasswordViewController.from(from: .main, with: .forgot)
    
    private var signup: SignupCoordinator!
    
    override func start() {
        super.start()
        router.setRootModule(controller, hideBar: true)
        self.onStart()
    }
    
    private func onStart() {
        controller.router = self
        forgot.router = self
    }
    
    private func startSignup() {
        signup = SignupCoordinator(router: Router())
        add(signup)
        signup.delegate = self
        signup.start()
        self.router.present(signup, animated: true)
    }
    
    private func startForgotPassword() {
        self.router.present(forgot, animated: true)
    }
}

extension LoginCoordinator: NextSceneDismisser {
    
    func push(scene: Scenes) {
        switch scene {
        case .signup: startSignup()
        case .forgot: startForgotPassword()
        default: break
        }
    }
    
    func dismiss(controller: Scenes) {
        switch  controller {
        case .forgot:
            router.dismissModule(animated: true, completion: nil)
        default:
            delegate?.dismiss(coordinator: self)
        }
    }
}

extension LoginCoordinator: CoordinatorDimisser {
    
    func dismiss(coordinator: Coordinator<Scenes>) {
        remove(child: coordinator)
        router.dismissModule(animated: true, completion: nil)
    }
}

