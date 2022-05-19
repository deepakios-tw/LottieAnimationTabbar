//
//  TabbarCoordinator.swift
//  LottieAnimation
//
//  Created by Apple on 19/05/22.
//

import Foundation

final class TabbarCoordinator: Coordinator<Scenes> {
    
    weak var delegate: CoordinatorDimisser?
    let controller: TabBarController = TabBarController.from(from: .main, with: .tabbar)
    private var login: LoginCoordinator!
    private var welcome: OnboardingCoordinator!
    
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
    
    private func startWelcome() {
        let router = Router()
        welcome = OnboardingCoordinator(router: router)
        add(welcome)
        welcome.delegate = self
        welcome.start()
        self.router.present(welcome, animated: true)
    }
}

extension TabbarCoordinator: NextSceneDismisser {
    
    func push(scene: Scenes) {
        switch scene {
        case .login: startLogin()
        case .welcome: startWelcome()
        default: break
        }
    }
    
    func dismiss(controller: Scenes) {
        router.dismissModule(animated: true, completion: nil)
    }
}

extension TabbarCoordinator: CoordinatorDimisser {
    
    func dismiss(coordinator: Coordinator<Scenes>) {
        remove(child: coordinator)
        router.dismissModule(animated: true, completion: nil)
    }
}

