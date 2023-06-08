//
//  SceneDelegate.swift
//  StarWars
//
//  Created by Nikolay Trofimov on 07.06.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }

    let navController = UINavigationController(rootViewController: EpisodeViewController())
    navController.navigationBar.prefersLargeTitles = true

    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    window?.windowScene = windowScene
    window?.rootViewController = navController
    window?.makeKeyAndVisible()
  }
}
