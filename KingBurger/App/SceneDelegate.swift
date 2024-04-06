//
//  SceneDelegate.swift
//  KingBurguer
//
//  Created by Maxwell Farias on 06/09/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let local: LocalDataSource = .shared
    var homeCoordinator: HomeCoordinatorFlow!
    private let interactor = SplashInteractor()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        if let userAuth = local.getUserAuth() {
            if Date().timeIntervalSince1970 > Double(userAuth.expiresSeconds) {
                interactor.login(request: SplashRequest(refreshToken: userAuth.refreshToken), accessToken: userAuth.accessToken) { error in
                    DispatchQueue.main.async {
                        if error {
                            let signInCoordinator = SignInCoordinator(window: self.window)
                            signInCoordinator.start()
                        } else {
                            self.homeCoordinator = HomeCoordinator(window: self.window)
                            self.homeCoordinator.start()
                        }
                    }
                }
            } else {
                homeCoordinator = HomeCoordinator(window: window)
                homeCoordinator.start()
            }
        } else {
            let signInCoordinator = SignInCoordinator(window: window)
            signInCoordinator.start()
        }
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

