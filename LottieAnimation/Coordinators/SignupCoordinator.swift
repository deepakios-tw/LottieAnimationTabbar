//
//  SignupCoordinator.swift
//  Coordinators
//
//  Created by Dr.Mac on 15/04/22.
//

import Foundation

final class SignupCoordinator: Coordinator<Scenes> {
    
    weak var delegate: CoordinatorDimisser?
    let controller: SignupViewController = SignupViewController.from(from: .main, with: .signup)
    private var welcome: OnboardingCoordinator!
    private var login: LoginCoordinator!
    
    override func start() {
        super.start()
        router.setRootModule(controller, hideBar: true)
        self.onStart()
    }
    
    private func onStart() {
        controller.router = self
    }
    
    private func startLogin() {
        let router = Router()
        login = LoginCoordinator(router: router)
        add(login)
        login.delegate = self
        login.start()
        self.router.present(login, animated: true)
    }
}

extension SignupCoordinator: NextSceneDismisser {
    
    func push(scene: Scenes) {
        switch scene {
        case .login: startLogin()
        default: break
        }
    }
    
    func dismiss(controller: Scenes) {
        delegate?.dismiss(coordinator: self)
    }
}

extension SignupCoordinator: CoordinatorDimisser {
    
    func dismiss(coordinator: Coordinator<Scenes>) {
        remove(child: coordinator)
        router.dismissModule(animated: true, completion: nil)
    }
}

