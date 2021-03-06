//
//  AppDelegate.swift
//  LottieAnimation
//
//  Created by Apple on 19/05/22.
//

import UIKit

var appDelegate = UIApplication.shared.delegate as? AppDelegate
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  var rootController = RootCoordinator()
  static var shared: AppDelegate {
      return UIApplication.shared.delegate as! AppDelegate
  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    self.setRootController()
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }

  // MARK: setRootController
  func setRootController() {
      self.window = UIWindow(frame: UIScreen.main.bounds)
      if let window = window {
          self.rootController.start(window: window)
      }
  }
}

