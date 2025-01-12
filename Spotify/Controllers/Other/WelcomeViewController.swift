//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by Pavel Maal on 3.09.24.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle("Sign In with Spotify", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "screen")
        return imageView
    }()
    
    private let overlayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.7
        return view
    }()
    
    private let centerLogoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "welcome_screen_logo")
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 32, weight: .semibold)
        label.text = "Listen to Millions\nof Songs on\nto go"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Spotify"
        view.backgroundColor = .blue
        positionOfSubviews()
        
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    @objc func didTapSignIn() {
        let vc = AuthViewController()
        vc.comletionHandler = { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func handleSignIn(success: Bool) {
        // Log user in or yell at them for error
        guard success else {
            let alert = UIAlertController(title: "Oops",
                                          message: "Something went wrong when signing in",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        
        let mainAppTabBarVC = TabBarViewController()
        mainAppTabBarVC.modalPresentationStyle = .fullScreen
        present(mainAppTabBarVC, animated: true)
    }
    
    private func positionOfSubviews() {
        view.addSubview(imageView)
        view.addSubview(overlayView)
        view.addSubview(centerLogoView)
        view.addSubview(label)
        view.addSubview(signInButton)
        
        let imageSize = view.width/3
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
            
            overlayView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            overlayView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            overlayView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            overlayView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
            
            centerLogoView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            centerLogoView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -20.0),
            centerLogoView.widthAnchor.constraint(equalToConstant: imageSize),
            centerLogoView.heightAnchor.constraint(equalToConstant: imageSize),
            
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.topAnchor.constraint(equalTo: centerLogoView.bottomAnchor, constant: 30.0),
            label.widthAnchor.constraint(equalToConstant: view.width - 60.0),
            label.heightAnchor.constraint(equalToConstant: 150.0),
            
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20.0),
            signInButton.widthAnchor.constraint(equalToConstant: view.width - 80.0),
            signInButton.heightAnchor.constraint(equalToConstant: 60.0)
        ])
    }
}
