//
//  PlayerControlsView.swift
//  Spotify
//
//  Created by Pavel Maal on 8.11.24.
//

import Foundation
import UIKit

protocol PlayerControlsViewDelegate: AnyObject {
    func playerControlsViewDidTapPlayPauseButton(_ player: PlayerControlsView)
    func playerControlsViewDidTapForwardButton(_ player: PlayerControlsView)
    func playerControlsViewDidTapBackwordsButton(_ player: PlayerControlsView)
    func playerControlsView(_ player: PlayerControlsView, didSlideSlider value: Float)
}

struct PlayerControlsViewModel {
    let title: String?
    let subtitle: String?
}

final class PlayerControlsView: UIView {
    
    private var isPlaying = true
    
    weak var delegate: PlayerControlsViewDelegate?
    
    private let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0.5
        return slider
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .label
        let image = UIImage(systemName: "backward.fill",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 34.0, weight: .regular)
        )
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .label
        let image = UIImage(systemName: "forward.fill",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 34.0, weight: .regular)
        )
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let playPauseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .label
        let image = UIImage(systemName: "pause",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 34.0, weight: .regular)
        )
        button.setImage(image, for: .normal)
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setUpPositionOfSubviews()
        
        backButton.addTarget(self, action: #selector (didTapBack), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector (didTapNext), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector (didTapPlayPause), for: .touchUpInside)
        volumeSlider.addTarget(self, action: #selector(didSlideSlider), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Objc methods
    
    @objc private func didTapBack() {
        delegate?.playerControlsViewDidTapBackwordsButton(self)
    }
    
    @objc private func didTapNext() {
        delegate?.playerControlsViewDidTapForwardButton(self)
    }
    
    @objc private func didTapPlayPause() {
        self.isPlaying.toggle()
        delegate?.playerControlsViewDidTapPlayPauseButton(self)
        
        // Update icon
        
        let pause = UIImage(systemName: "pause",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 34.0, weight: .regular)
        )
        let play = UIImage(systemName: "play.fill",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 34.0, weight: .regular)
        )
        playPauseButton.setImage(isPlaying ? pause : play, for: .normal)
    }
    
    @objc private func didSlideSlider(_ slider: UISlider) {
        let value = slider.value
        delegate?.playerControlsView(self, didSlideSlider: value)
    }
    
    // MARK: - Configuration of subviews
    
    private func setUpPositionOfSubviews() {
        self.addSubview(nameLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(volumeSlider)
        self.addSubview(backButton)
        self.addSubview(nextButton)
        self.addSubview(playPauseButton)

        self.clipsToBounds = true
        let buttonSize = 60.0
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(
                equalTo: self.topAnchor),
            nameLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor, constant: 10.0),
            nameLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor, constant: -10.0),
            nameLabel.heightAnchor.constraint(equalToConstant: 50.0),
            
            subtitleLabel.topAnchor.constraint(
                equalTo: nameLabel.bottomAnchor, constant: 10.0),
            subtitleLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor, constant: 10.0),
            subtitleLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor, constant: -10.0),
            subtitleLabel.heightAnchor.constraint(
                equalToConstant: 50.0),
            
            volumeSlider.topAnchor.constraint(
                equalTo: subtitleLabel.bottomAnchor, constant: 20.0),
            volumeSlider.leadingAnchor.constraint(
                equalTo: self.leadingAnchor, constant: 10.0),
            volumeSlider.widthAnchor.constraint(
                equalTo: self.widthAnchor, constant: -20.0),
            volumeSlider.heightAnchor.constraint(
                equalToConstant: 44.0),
            
            playPauseButton.topAnchor.constraint(
                equalTo: volumeSlider.bottomAnchor, constant: 30.0),
            playPauseButton.centerXAnchor.constraint(
                equalTo: self.centerXAnchor),
            playPauseButton.widthAnchor.constraint(
                equalToConstant: buttonSize),
            playPauseButton.heightAnchor.constraint(
                equalToConstant: buttonSize),
            
            backButton.topAnchor.constraint(
                equalTo: playPauseButton.topAnchor),
            backButton.trailingAnchor.constraint(
                equalTo: playPauseButton.leadingAnchor, constant: -20.0),
            backButton.widthAnchor.constraint(
                equalToConstant: buttonSize),
            backButton.heightAnchor.constraint(
                equalToConstant: buttonSize),
            
            nextButton.topAnchor.constraint(
                equalTo: playPauseButton.topAnchor),
            nextButton.leadingAnchor.constraint(
                equalTo: playPauseButton.trailingAnchor, constant: 20.0),
            nextButton.widthAnchor.constraint(
                equalToConstant: buttonSize),
            nextButton.heightAnchor.constraint(
                equalToConstant: buttonSize),
        ])
    }
    
    func configure(with viewModel: PlayerControlsViewModel) {
        nameLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }
}
