//
//  SceneDelegate.swift
//  YearEndAssignment
//
//  Created by bene9275 on 2021/12/31.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        
        /*
         1. 로그인 한적 있는 경우 => 기존 정보 활용
            - 1) 기존 정보로 로그인 성공
            - 2) 기존 정보로 로그인 실패
         2. 로그인 한적 없는 경우
         */
    
        let duration = 0.5
        let options = UIView.AnimationOptions.transitionCrossDissolve
        
        if let identifier = UserDefaults.standard.string(forKey: "identifier"), let password = UserDefaults.standard.string(forKey: "password") {

            APIService.signin(identifier: identifier, password: password) { data, error in

                var rootViewController: UIViewController

                if let data = data {
                    print("로그인 성공!")
                    UserDefaults.standard.set(data.jwt, forKey: "token")

                    rootViewController = PostViewController()
                } else {
                    print("로그인 실패!")
                    dump(error)

                    rootViewController = AuthViewController()
                }
                self.window?.changeRootViewControllerWithAnimation(duration: duration, options: options, rootViewController: rootViewController)
            }

        } else {
        
            let rootViewController = AuthViewController()
            self.window?.changeRootViewControllerWithAnimation(duration: duration, options: options, rootViewController: rootViewController)
        }
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
       
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

