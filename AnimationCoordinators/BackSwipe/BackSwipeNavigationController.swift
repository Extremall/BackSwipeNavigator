//
//  BackSwipeNavigationController.swift
//  AnimationCoordinators
//
//  Created by Alexander Naumenko on 11/09/2022.
//

import UIKit

class BackSwipeNavigationController: UINavigationController {
    lazy var navigationData: BackSwipeNavigationData = {
        let data = BackSwipeNavigationData()
        return data
    }()

    lazy var backSwipeManager: BackSwipeNavManager = {
        let manager = BackSwipeNavManager(data: self.navigationData, navController: self)
        return manager
    }()

    /// Pan gesture for the swiping interaction
    lazy var panGestureRecognizer: UIPanGestureRecognizer = {
        UIPanGestureRecognizer(target: backSwipeManager,
                               action: #selector(BackSwipeNavManager.handlePanGesture(_:)))
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        configure()
    }

    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        configure()
    }

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        configure()
    }

    func configure() {
        delegate = backSwipeManager
        panGestureRecognizer.isEnabled = true
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    override func pushViewController(_ contoller: UIViewController, animated: Bool) {
        navigationData.duringPushAnimation = true
        super.pushViewController(contoller, animated: animated)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
