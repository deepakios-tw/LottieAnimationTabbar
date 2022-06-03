//
//  LottieImageView.swift
//  Wellthy
//
//  Created by Santosh Gupta on 14/03/18.
//  Copyright © 2018 Kiruthika Selvavinayagam. All rights reserved.
//

import UIKit
import Lottie

class LottieImageView: UIImageView {
    
    var lottieAnimationView : AnimationView?
    
    func loadLottie(name: String, mode: ContentMode = .scaleAspectFill) {
        let lottieAnimationView = AnimationView(name: name)
        lottieAnimationView.frame = self.bounds
        lottieAnimationView.contentMode = mode
        lottieAnimationView.backgroundBehavior = .pauseAndRestore
        self.addSubview(lottieAnimationView)
        self.lottieAnimationView?.removeFromSuperview()
        self.lottieAnimationView = lottieAnimationView
    }
    
    func loadLottie(url: URL, widthValue: CGFloat, heightValue: CGFloat) {
        let lottieAnimationView = AnimationView(filePath: url.path)
        lottieAnimationView.frame = CGRect(x: 0, y: 0,width: widthValue, height: heightValue)
        lottieAnimationView.contentMode = .scaleAspectFit
        self.addSubview(lottieAnimationView)
        self.lottieAnimationView?.removeFromSuperview()
        self.lottieAnimationView = lottieAnimationView
    }
    
    func loadLottie(url: URL) {
        let lottieAnimationView = AnimationView(filePath: url.path)
        lottieAnimationView.frame = self.bounds
        lottieAnimationView.contentMode = .scaleAspectFill
        lottieAnimationView.backgroundBehavior = .pauseAndRestore
        self.addSubview(lottieAnimationView)
        self.lottieAnimationView?.removeFromSuperview()
        self.lottieAnimationView = lottieAnimationView
    }
    
    func loadLottie(name: String, fromProgress : CGFloat = 0.0, toProgress: CGFloat = 0.0, inLoop: Bool, completion: (()->Void)?) {
        self.loadLottie(name: name)
        self.lottieAnimationView?.loopMode = inLoop ? .loop : .playOnce
        self.play(fromProgress: fromProgress, toProgress: toProgress)
        self.lottieAnimationView?.play(fromProgress: fromProgress, toProgress: toProgress, loopMode: inLoop ? .loop : .playOnce, completion: { (finished) in
            completion?()
        })
    }
    
    func loadLottie(lottieName: String) {
        self.loadLottie(name: lottieName)
        self.lottieAnimationView?.loopMode = .playOnce
        self.lottieAnimationView?.play()
        self.lottieAnimationView?.backgroundBehavior = .pauseAndRestore
    }
    
    func play(fromProgress: CGFloat = 0.0, toProgress: CGFloat, inLoop: Bool = false) {
        
        if inLoop {
            self.lottieAnimationView?.play(fromProgress: fromProgress, toProgress: toProgress, loopMode: .loop, completion: nil)
        } else {
            self.lottieAnimationView?.play(fromProgress: fromProgress, toProgress: toProgress, loopMode: .playOnce, completion: nil)
        }
    }
    
    func resetLottie() {
        self.lottieAnimationView?.removeFromSuperview()
    }
    
}

////////////////////
import UIKit

extension UIDevice {
    var iPhone: Bool {
        return UIDevice().userInterfaceIdiom == .phone
    }
    enum ScreenType: String {
        case iPhone4
        case iPhone5
        case iPhone6
        case iPhone6Plus
        case iPhoneX
        case iPhoneXr
        case iPhoneXsMax
        case iPhone12Mini
        case iPhone12
        case iPhone12ProMax
        case Unknown
    }
    var screenType: ScreenType? {
        guard iPhone else { return nil }
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhone4
        case 1136:
            return .iPhone5
        case 1334:
            return .iPhone6
        case 2208:
            return .iPhone6Plus
        case 2436:
            return .iPhoneX
        case 1792:
            return .iPhoneXr
        case 2688:
            return .iPhoneXsMax
        case 2340:
            return .iPhone12Mini
        case 2532:
            return .iPhone12
        case 2778:
            return .iPhone12ProMax
        default:
            return getDeviceType()
        }
    }
    
    func getDeviceType() -> ScreenType {
        
        let deviceName = getDeviceName()
        
        if ["iPhone 4", "iPhone 4s"].contains(deviceName) {
            return .iPhone4
        } else if ["iPhone 5", "iPhone 5c", "iPhone 5s", "iPhone SE"].contains(deviceName) {
            return .iPhone5
        } else if ["iPhone 6", "iPhone 7", "iPhone 6s", "iPhone 8"].contains(deviceName) {
            return .iPhone6
        } else if ["iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus"].contains(deviceName) {
            return .iPhone6Plus
        } else if deviceName == "iPhone X" {
            return .iPhoneX
        } else {
            return .Unknown
        }
    }
    
    func getDeviceName() -> String {
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
            
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPhone13,1":                              return "iPhone 12 Mini"
        case "iPhone13,2":                              return "iPhone 12"
        case "iPhone13,3":                              return "iPhone 12 Pro"
        case "iPhone13,4":                              return "iPhone 12 Pro Max"
        default:                                        return identifier
        }
    }
    
    // helper funcs
    static func isScreen35inch() -> Bool {
        return UIDevice().screenType == .iPhone4
    }
    
    static func isScreen4inch() -> Bool {
        return UIDevice().screenType == .iPhone5
    }
    
    static func isScreen47inch() -> Bool {
        return UIDevice().screenType == .iPhone6
    }
    
    static func isScreen55inch() -> Bool {
        return UIDevice().screenType == .iPhone6Plus
    }
    
    static func isScreen57inch() -> Bool {
        return UIDevice().screenType == .iPhoneX
    }
    
    static func isScreen61inch() -> Bool {
        return UIDevice().screenType == .iPhoneXr || UIDevice().screenType == .iPhone12
    }
    
    static func isScreen65inch() -> Bool {
        return UIDevice().screenType == .iPhoneXsMax || UIDevice().screenType == .iPhone12ProMax
    }
    
    static func isScreenLessThan47inch() -> Bool {
        return UIDevice().screenType == .iPhone4 || UIDevice().screenType == .iPhone5
    }
    
    static func isScreenBiggerThan47inch() -> Bool {
        return UIDevice().screenType != .iPhone4 && UIDevice().screenType != .iPhone5 && UIDevice().screenType != .iPhone6
    }
    
    static func isSmallDevive() -> Bool {
        if UIDevice.isScreen57inch() || UIDevice.isScreen61inch() || UIDevice.isScreen65inch() {
            return false
        } else {
            return true
        }
    }
    
    static func getCustomKeyboardHeight() -> CGFloat? {
        if let type: ScreenType = UIDevice().screenType {
            switch type {
            case .iPhone4:
                return 216
            case .iPhone5:
                return 216
            case .iPhone6:
                return 216
            case .iPhone6Plus:
                return 226
            case .iPhoneX, .iPhoneXr, .iPhoneXsMax:
                return 267
            default:
                return 226
            }
        } else {
            return 226
        }
    }
    
    static func safeAreaBottomInset() -> CGFloat {
        
        if #available(iOS 11.0, *) {
            
            if let insetHeight = appDelegate?.window?.safeAreaInsets {
                return insetHeight.bottom
            } else {
                return 0
            }
            
        } else {
            return 0
        }
    }
    
    static func safeAreaTopInset() -> CGFloat {
        
        if #available(iOS 11.0, *) {
            
            if let insetHeight = appDelegate?.window?.safeAreaInsets {
                return insetHeight.top
            } else {
                return 0
            }
            
        } else {
            return 0
        }
    }
    
    static func is32BitDevice() -> Bool {
        if MemoryLayout<Int>.size == 4 {
            return true
        } else {
            return false
        }
    }
}

extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}

struct Platform {
    
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}

extension UIView {
    func findViews<T: UIView>(subclassOf: T.Type) -> [T] {
        return recursiveSubviews.compactMap { $0 as? T }
    }
    
    var recursiveSubviews: [UIView] {
        return subviews + subviews.flatMap { $0.recursiveSubviews }
    }
}
