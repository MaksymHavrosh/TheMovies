//
//  SceneDelegate.swift
//  TheMovies
//
//  Created by MG on 19.08.2020.
//  Copyright © 2020 MG. All rights reserved.
//

import UIKit
import Network

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private let networkMonitor = NWPathMonitor()
    private var alert = UIAlertController()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        addPathUpdateHandler()
        guard let _ = (scene as? UIWindowScene) else { return }
    }

}

//MARK: - Check internet connection

private extension SceneDelegate {
    
    func createAlertController() {
        
        alert = UIAlertController(title: NSLocalizedString("Ошибка!", comment: ""), message: NSLocalizedString("Нет соединения", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Настройки", comment: ""), style: .default, handler: { _ in
            
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(url, options: [:])
        }))
    }
    
    func addPathUpdateHandler() {
        
        createAlertController()
        
        networkMonitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                
                if path.status == .unsatisfied, !self.alert.isFirstResponder {
                    self.window?.rootViewController?.present(self.alert, animated: true, completion: nil)
                    
                } else {
                    self.alert.dismiss(animated: true, completion: nil)
                }
            }
        }
        networkMonitor.start(queue: DispatchQueue.main)
    }
    
}

