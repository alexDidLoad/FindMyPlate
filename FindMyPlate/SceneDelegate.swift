//
//  SceneDelegate.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 1/29/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        configureNavBar()
        window                       = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene          = windowScene
        window?.rootViewController   = FMPTabBar()
        window?.makeKeyAndVisible()
    }
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
       
    }
    
    
    func sceneDidBecomeActive(_ scene: UIScene) {
       
    }
    
    
    func sceneWillResignActive(_ scene: UIScene) {
       
    }
    
    
    func sceneWillEnterForeground(_ scene: UIScene) {
      
    }
    
    
    func sceneDidEnterBackground(_ scene: UIScene) {
       
        
    }
    
    //MARK: - Helpers
    
    func configureNavBar() {
        UINavigationBar.appearance().barStyle               = .black
        UINavigationBar.appearance().tintColor              = .white
        UINavigationBar.appearance().barTintColor           = .systemRed
        UINavigationBar.appearance().titleTextAttributes    = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .bold),
                                                               NSAttributedString.Key.foregroundColor : UIColor.white]
    }
}

