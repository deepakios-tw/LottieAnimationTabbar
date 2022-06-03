//
//  OnboardingCoordinator.swift
//  Coordinators
//
//  Created by Dr.Mac on 14/04/22.
//

import Foundation

final class OnboardingCoordinator: Coordinator<Scenes> {
    
    weak var delegate: CoordinatorDimisser?
    private var welcome: WelcomeCoordinator!
    let controller: SplashViewController = SplashViewController.from(from: .main, with: .splash)
    
    override func start() {
        super.start()
        router.setRootModule(controller, hideBar: true)
        self.onStart()
    }
    
    private func onStart() {
        controller.router = self
    }
    
    private func startWelcome() {
        router.dismissModule(animated: false, completion: nil)
        welcome = WelcomeCoordinator(router: Router())
        add(welcome)
        welcome.delegate = self
        welcome.start()
        self.router.present(welcome, animated: true)
    }
}

extension OnboardingCoordinator: NextSceneDismisser {
    func push(scene: Scenes) {
        switch scene {
        case .welcome: startWelcome()
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

