//
//  SplashViewController.swift
//  LottieAnimation
//
//  Created by Apple on 26/05/22.
//

import UIKit

class SplashViewController: UIViewController {
    
    @IBOutlet weak var splashView: LottieImageView!
    weak var router: NextSceneDismisser?
    
    var completionArray = [(()->Void)?]()
    var waitingTime = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLottieView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showLottieView()
    }
    
    func showLottieView() {
        if let path = Bundle.main.url(forResource: "splash", withExtension: "json") {
            splashView.loadLottie(url: path) //
            self.splashView.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.1098039216, blue: 0.1137254902, alpha: 1)
            self.splashView.lottieAnimationView?.play(fromFrame: 0, toFrame: 17, loopMode: .loop, completion: { (done) in
                
            })
            self.runningApi()
        }
    }
    
    func animationAfterApiCall() {
        self.splashView.lottieAnimationView?.play(fromProgress: 0.0, toProgress: 1.0, loopMode: .playOnce, completion: { (done) in
            UIView.animate(withDuration: 0.3, delay: 0.3, options: []) {
                self.view.alpha = 0.0
            } completion: { (d) in
                self.view.removeFromSuperview()
                self.completionArray.forEach { (c) in
                    c?()
                }
                self.completionArray.removeAll()
                self.router?.push(scene: .welcome)
            }
        })
    }
    
    @objc func runningApi() {
        self.waitingTime -= 1
        if self.waitingTime == 0 {
            animationAfterApiCall()
        }
        else {
            self.perform(#selector(self.runningApi), with: nil, afterDelay: 1.0)
        }
    }
}


