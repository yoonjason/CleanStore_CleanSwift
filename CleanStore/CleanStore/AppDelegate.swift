//
//  AppDelegate.swift
//  CleanStore
//
//  Created by Bradley.yoon on 2023/05/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
//        let vc = CreateOrderViewController()
//        let navigatonController = UINavigationController(rootViewController: CreateOrderViewController())
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let navigationController = storyboard.instantiateViewController(withIdentifier: "navi") as? UINavigationController
        
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "createOrder") as? CreateOrderViewController
        let navigatonController = UINavigationController(rootViewController: rootViewController!)
//        let viewController = UIViewController()
        
//        navigationController!.viewControllers = [rootViewController]
        
//        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
                
        
        return true
    }



}

