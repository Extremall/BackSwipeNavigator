//
//  FirstViewController.swift
//  AnimationCoordinators
//
//  Created by Alexander Naumenko on 11/09/2022.
//

import UIKit

class FirstViewController: UIViewController {

    lazy var buttonNext: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.addTarget(self, action: #selector(buttonNextTouchedUpInside), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .yellow
        
        view.addSubview(buttonNext)
        
        NSLayoutConstraint.activate([
            buttonNext.widthAnchor.constraint(equalToConstant: 150),
            buttonNext.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonNext.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonNext.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: - Actions
extension FirstViewController {
    @objc func buttonNextTouchedUpInside() {
        let secondVC = SecondViewController()
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
}

// MARK: - UIGestureRecognizerDelegate
extension FirstViewController: UIGestureRecognizerDelegate {
    
}

