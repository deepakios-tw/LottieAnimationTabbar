//
//  OnboardingCoordinator.swift
//  Coordinators
//
//  Created by Dr.Mac on 14/04/22.
//

import Foundation

final class OnboardingCoordinator: Coordinator<Scenes> {

    weak var delegate: CoordinatorDimisser?
      private var login: LoginCoordinator!
      private var tabbar: TabbarCoordinator!
      private var signup: SignupCoordinator!
      private var onboarding: OnboardingCoordinator!
      let controller: WelcomeViewController = WelcomeViewController.from(from: .main, with: .welcome)

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

    private func startSignup() {
        router.dismissModule(animated: false, completion: nil)
        signup = SignupCoordinator(router: Router())
        add(signup)
        signup.delegate = self
        signup.start()
        self.router.present(signup, animated: true)
    }
    
    private func startTabbarFlow() {
        let router = Router()
        tabbar = TabbarCoordinator(router: router)
        add(tabbar)
        tabbar.delegate = self
        tabbar.start()
        self.router.present(tabbar, animated: true)
    }
}

extension OnboardingCoordinator: NextSceneDismisser {
    func push(scene: Scenes) {
        switch scene {
        case .login: startLogin()
        case .signup: startSignup()
        case .tabbar: startTabbarFlow()
        default: break
        }
    }

    func dismiss(controller: Scenes) {
        router.dismissModule(animated: true, completion: nil)
    }
}

extension OnboardingCoordinator: CoordinatorDimisser {
    func dismiss(coordinator: Coordinator<Scenes>) {
        remove(child: coordinator)
        router.dismissModule(animated: true, completion: nil)
    }
}

