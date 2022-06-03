//
//  ForgotPasswordViewController.swift
//  Coordinators
//
//  Created by Dr.Mac on 15/04/22.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var btnSend:UIButton!
    @IBOutlet weak var btnBack:UIButton!
    
    weak var router: NextSceneDismisser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [self.btnSend, btnBack].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
    }
}

// MARK: Button Action
extension ForgotPasswordViewController {
    @objc func buttonPressed(_ sender: UIButton) {
        switch  sender {
        case btnSend:
            print("btn send pressed")
        case btnBack:
            self.backAction()
        default:
            break
        }
    }
    
    private func backAction() {
        self.router?.dismiss(controller: .forgot)
    }
}
