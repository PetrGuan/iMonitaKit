//
//  DisplayManager.swift
//  iMonitaKit
//
//  Created by Petr Guan on 2021/10/21.
//

import Combine
import UIKit

public class DisplayAttacher {
    private var pipelines: [UIViewController: AnyCancellable?] = [:]
    private var onScreenViewControllers: Set<UIViewController> = []
    
    // MARK: - Public
    
    public init() {}
    
    /// Attach the viewController to the window hierarchy
    /// - Parameters:
    ///   - viewController: The viewController you want to attach
    ///   - window: The window you want to attach to
    public func attach(_ viewController: UIViewController, to window: UIWindow) {
        window.addSubview(viewController.view)
        onScreenViewControllers.insert(viewController)
    }
    
    /// Detach the current displaying viewController
    /// - Parameters:
    ///   - viewController: The viewController you want to detach
    public func detach(_ viewController: UIViewController) {
        guard onScreenViewControllers.contains(viewController) else {
            return
        }
        
        viewController.view.removeFromSuperview()
        onScreenViewControllers.remove(viewController)
    }
}
