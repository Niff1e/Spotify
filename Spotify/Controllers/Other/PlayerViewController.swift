//
//  PlayerViewController.swift
//  Spotify
//
//  Created by Pavel Maal on 3.09.24.
//

import UIKit
import SDWebImage

protocol PlayerViewControllerDelegate: AnyObject {
    func didTapPlayPause()
    func didTapForward()
    func didTapBackward()
    func didSlideSlider(to value: Float)
    func didTapCloseButton()
}

class PlayerViewController: UIViewController {
    
    weak var dataSource: PlayerDataSource?
    weak var delegate: PlayerViewControllerDelegate?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let controlsView = PlayerControlsView()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpPositionOfSubviews()
        configureBarButtonItems()
        configure()
        controlsView.delegate = self
    }
    
    // MARK: - Configuration of subviews
    
    private func configure() {
        imageView.sd_setImage(with: dataSource?.imageURL, completed: nil)
        controlsView.configure(with: PlayerControlsViewModel(title: dataSource?.songName,
                                                             subtitle: dataSource?.subtitle)
        )
    }
    
    private func setUpPositionOfSubviews() {
        view.addSubview(imageView)
        view.addSubview(controlsView)
        
        controlsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor),
            
            controlsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0),
            controlsView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10.0),
            controlsView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20.0),
            controlsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15.0)
        ])
    }
    
    private func configureBarButtonItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapAction))
    }
    
    // MARK: - Objc methods
    
    @objc private func didTapClose() {
        delegate?.didTapCloseButton()
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapAction() {
        // Actions
    }
    
    // MARK: - Internal methods
    
    func refreshUI() {
        configure()
    }
}


extension PlayerViewController: PlayerControlsViewDelegate {
    func playerControlsView(_ player: PlayerControlsView, didSlideSlider value: Float) {
        delegate?.didSlideSlider(to: value)
    }
    
    func playerControlsViewDidTapPlayPauseButton(_ player: PlayerControlsView) {
        delegate?.didTapPlayPause()
    }
    
    func playerControlsViewDidTapForwardButton(_ player: PlayerControlsView) {
        delegate?.didTapForward()
    }
    
    func playerControlsViewDidTapBackwordsButton(_ player: PlayerControlsView) {
        delegate?.didTapBackward()
    }
}
