//
//  LibraryToggleView.swift
//  Spotify
//
//  Created by Pavel Maal on 5.12.24.
//

import UIKit

protocol LibraryToggleViewDelegate: AnyObject {
    func libraryToggleViewDidTapPlaylists(_ toggleView: LibraryToggleView)
    func libraryToggleViewDidTapAlbums(_ toggleView: LibraryToggleView)
}

class LibraryToggleView: UIView {
    
    enum State {
        case playlists
        case albums
    }
    
    var state: State = .playlists
    
    weak var delegate: LibraryToggleViewDelegate?
    
    private let playlistButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Playlists", for: .normal)
        return button
    }()
    
    private let albumsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Albums", for: .normal)
        return button
    }()
    
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 4
        return view
    }()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        positionOfSubviews()
        playlistButton.addTarget(self, action: #selector(playlistButtonTapped), for: .touchUpInside)
        albumsButton.addTarget(self, action: #selector(albumsButtonTapped), for: .touchUpInside)
        layoutIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Objc
    
    @objc private func playlistButtonTapped() {
        state = .playlists
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
        delegate?.libraryToggleViewDidTapPlaylists(self)
    }
    
    @objc private func albumsButtonTapped() {
        state = .albums
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
        delegate?.libraryToggleViewDidTapAlbums(self)
    }
    
    private func positionOfSubviews() {
        addSubview(albumsButton)
        addSubview(playlistButton)
        addSubview(indicatorView)
        
        playlistButton.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        albumsButton.frame = CGRect(x: playlistButton.right, y: 0, width: 100, height: 40)
    }
    
    private func layoutIndicator() {
        switch state {
        case .playlists:
            indicatorView.frame = CGRect(x: 0, y: playlistButton.bottom, width: 100.0, height: 3.0)
        case .albums:
            indicatorView.frame = CGRect(x: 100, y: playlistButton.bottom, width: 100.0, height: 3.0)
        }
    }
    
    // MARK: - State of Indicator
    
    func update(for state: State) {
        self.state = state
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
    }
}
