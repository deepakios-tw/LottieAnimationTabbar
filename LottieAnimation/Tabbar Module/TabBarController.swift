//
//  TabBarController.swift
//  LottieAnimation
//
//  Created by Apple on 19/05/22.
//

import UIKit
import Lottie
enum TabBarItem: Int {
    case home = 0
    case community
    case chat
    case notification
    case profile
}


class TabBarController: UITabBarController {
    
    let kBarHeight: CGFloat = 60
    let SCREEN_WIDTH =  UIScreen.main.bounds.size.width
    weak var router: NextSceneDismisser?
    var selectedTabIndex: Int = 0
    var toggle:Bool = false
    var home: HomeViewController = HomeViewController.from(from: .main, with: .home)
    var community: CommunityViewController = CommunityViewController.from(from: .main, with: .community)
    var chat: ChatViewController = ChatViewController.from(from: .main, with: .chat)
    var notification: NotificationViewController = NotificationViewController.from(from: .main, with: .notification)
    var profile: ProfileViewController = ProfileViewController.from(from: .main, with: .profile)
    var tabBarIcons: [UIImage?] = [UIImage(named: "ic_tab_home_unselected"),
                                  UIImage(named: "ic_tab_magazine_unselected"),
                                  UIImage(named: "ic_tab_chat_unselected"),
                                  UIImage(named: "ic_tab_diary_unselected"),
                                  UIImage(named: "ic_tab_profile_unselected")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = kBarHeight
        tabFrame.origin.y = self.view.frame.size.height - kBarHeight
        self.tabBar.frame = tabFrame
    }
}

// MARK: Instance Method
extension TabBarController {
    private func setup() {
        self.setupItems()
        self.setTabbar()
    }
    
    private func setTabbar() {
        self.delegate = self
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: 20)
        self.tabBar.layer.shadowRadius = 10
        self.tabBar.layer.shadowColor = UIColor.black.cgColor
        self.tabBar.layer.shadowOpacity = 0.3
        self.tabBar.isTranslucent = true
        self.tabBar.clipsToBounds = true
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = .black
        self.tabBar.unselectedItemTintColor = UIColor.black
        self.tabBar.itemPositioning = .automatic
        self.selectedIndex = 0
        self.tabBar.backgroundColor = UIColor.white
    }
    
    func setupItems() {
        let top = UIDevice.safeAreaBottomInset() > 0 ? 6 : 2 //to match frame change of image and lottie
        let titleVertical = UIDevice.safeAreaBottomInset() > 0 ? 4 : -2
        let edgeInsets = UIEdgeInsets(top: CGFloat(top), left: 0, bottom: -CGFloat(top), right: 0)
        let titleInsets = UIOffset(horizontal: 0, vertical: CGFloat(titleVertical))

        let home = UITabBarItem()
        home.image = UIImage(named: "ic_tab_home_unselected")
        home.title = "Home"
        home.tag = 0
        
        let community = UITabBarItem()
        community.image = UIImage(named: "ic_tab_magazine_unselected")
        community.tag = 1
        community.title = "Community"
        
        let chat = UITabBarItem()
        chat.image = UIImage(named: "ic_tab_chat_unselected")
        chat.title = "Chat"
        chat.tag = 2
        
        let notification = UITabBarItem()
        notification.image = UIImage(named: "ic_tab_diary_unselected")
        notification.title = "Diary"
        notification.tag = 3
        
        let myAccount = UITabBarItem()
        myAccount.image = UIImage(named: "ic_tab_profile_unselected")
        myAccount.title = "Profile"
        myAccount.tag = 4
        
        
        home.imageInsets = edgeInsets
        home.titlePositionAdjustment = titleInsets

        community.imageInsets = edgeInsets
        community.titlePositionAdjustment = titleInsets

        chat.imageInsets = edgeInsets
        chat.titlePositionAdjustment = titleInsets

        notification.imageInsets = edgeInsets
        notification.titlePositionAdjustment = titleInsets

        myAccount.imageInsets = edgeInsets
        myAccount.titlePositionAdjustment = titleInsets

        
        self.home.tabBarItem = home
        self.home.router = router
        
        self.community.tabBarItem = community
        self.community.router = router
        
        self.chat.tabBarItem = chat
        self.chat.router = router
        
        self.notification.tabBarItem = notification
        self.notification.router = router
        
        self.profile.tabBarItem = myAccount
        self.profile.router = router
        
        self.viewControllers = [self.home, self.community, self.chat, self.notification, self.profile]
        self.setViewControllers(self.viewControllers, animated: true)
        self.loadLottie(play: true, selectedTabIndex: self.selectedTabIndex)

    }
}

extension TabBarController : UITabBarControllerDelegate {
    func getIndexVC(index: Int, viewController: UIViewController) { // viewAtIndex
        switch index {
        case 0:
            print("Home")
            if viewController.isKind(of: HomeViewController.self) {
                (viewController as! HomeViewController).router = router
            }
        case 1:
            print("Comunity")
            if viewController.isKind(of: CommunityViewController.self) {
                (viewController as! CommunityViewController).router = router
            }
        case 2:
            if viewController.isKind(of: ChatViewController.self) {
                (viewController as! ChatViewController).router = router
            }
            print("chatVc")
        case 3:
            if viewController.isKind(of: NotificationViewController.self) {
                (viewController as! NotificationViewController).router = router
            }
            print("MyAccount")
        default:
            if viewController.isKind(of: ProfileViewController.self) {
                (viewController as! ProfileViewController).router = router
            }
            print("default")
        }
    }
    
    func loadLottie(play: Bool, selectedTabIndex: Int) {
        self.selectedTabIndex = selectedTabIndex
        let lottieList = self.lottieList()
        addLottieOnTabBarItems(lottieList: lottieList)
        self.reloadTabBarItemIcons(selectedTabIndex)
        self.playLottieForSelectTabIndex(selectedTabIndex, play: play)
    }

    private func lottieList() -> [(String, Int)] {
        var lottieList = [(String, Int)]()
        lottieList.append(("Home_tab_orange_light", TabBarItem.home.rawValue))
        lottieList.append(("Magazine_tab_orange_light", TabBarItem.community.rawValue))
        lottieList.append(("Chat_tab_orange_light", TabBarItem.chat.rawValue))
        lottieList.append(("Diary_tab_orange_light", TabBarItem.notification.rawValue))
        lottieList.append(("Profile_tab_orange_light", TabBarItem.profile.rawValue))
        return lottieList
    }
    
    private func addLottieOnTabBarItems(lottieList: [(String, Int)]) {
        let preAddedLotties = self.tabBar.findViews(subclassOf: UIStackView.self)
        preAddedLotties.forEach { (s) in
            s.removeFromSuperview()
        }
        
        let top = UIDevice.safeAreaBottomInset() > 0 ? 4 : 0
        let stackView = UIStackView(frame: CGRect(x: 0, y: top, width: Int(SCREEN_WIDTH), height: 35))
        stackView.backgroundColor = .clear
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        for lottie in lottieList {
            let baseViewWidth = Int(SCREEN_WIDTH) / lottieList.count
            let baseView = UIView(frame: CGRect(x: 0, y: 0, width: baseViewWidth , height: 40))
            baseView.isUserInteractionEnabled = false
            let v = LottieImageView(frame: CGRect(x: (baseViewWidth - 40) / 2,  y: 0, width: 40, height: 40))
            v.tag = lottie.1
            v.isUserInteractionEnabled = false
            if let path = Bundle.main.url(forResource: lottie.0, withExtension: "json") {
                v.loadLottie(url: path)
                baseView.addSubview(v)
                baseView.translatesAutoresizingMaskIntoConstraints = false
                stackView.addArrangedSubview(baseView)
            }
        }
        stackView.isUserInteractionEnabled = false
        tabBar.addSubview(stackView)
    }
    
    func playLottieForSelectTabIndex(_ index: Int, play: Bool) {
        self.reloadTabBarItemIcons(index)
        let lottieSubViews: [LottieImageView] = self.tabBar.findViews(subclassOf: LottieImageView.self)
        lottieSubViews.forEach { (lottie) in
            lottie.alpha = 0.0
        }
        if let lottieView = lottieSubViews.filter({ (lottieV) -> Bool in
            lottieV.tag == index
        }).first {
            lottieView.alpha = 1.0
            if play {
                lottieView.lottieAnimationView?.play(fromProgress: 0.0, toProgress: 1.0, loopMode: .playOnce) { (c) in
                }
            }
        }
    }
    
    func reloadTabBarItemIcons(_ selectedTabIndex: Int) {
        if let tabs = self.tabBar.items {
            for tab in tabs {
                let image = tabBarIcons[tab.tag]
                if tab.tag != selectedTabIndex {
                    tab.image = image?.withRenderingMode(.alwaysOriginal)
            }else {
                    tab.image = nil
                }
            }
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.playLottieForSelectTabIndex(item.tag, play: true)
        self.selectedTabIndex = item.tag
    }
    
    func updateTabBarImage(item: TabBarItem, image: UIImage?, update: Bool = false) {
        tabBarIcons[item.rawValue] = image
        self.reloadTabBarItemIcons(self.selectedTabIndex)
    }
}
