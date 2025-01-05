//
//  LibraryViewController.swift
//  Spotify
//
//  Created by Pavel Maal on 3.09.24.
//

import UIKit

class LibraryViewController: UIViewController {

    private let playlistsVC = LibraryPlaylistViewController()
    private let albumVC = LibraryAlbumsViewController()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let toggleView = LibraryToggleView()
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toggleView.delegate = self
        
        view.backgroundColor = .systemBackground
        setupPositionsOfSubviews()
        
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: view.width*2, height: scrollView.height)
        
        addChildren()
        
        updateBarButtons()
    }
    
    // MARK: - Layout and Subviews
    
    private func setupPositionsOfSubviews() {
        view.addSubview(scrollView)
        view.addSubview(toggleView)
        
        toggleView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 55),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            toggleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            toggleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toggleView.widthAnchor.constraint(equalToConstant: 200.0),
            toggleView.heightAnchor.constraint(equalToConstant: 55.0)
        ])
    }
    
    private func updateBarButtons() {
        switch toggleView.state {
        case .playlists:
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        case .albums:
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    // MARK: - Objc methods
    
    @objc private func didTapAdd() {
        playlistsVC.showCreatePlaylistAlert()
    }
    
    // MARK: - Children VC's
    
    private func addChildren() {
        addChild(playlistsVC)
        scrollView.addSubview(playlistsVC.view)
        playlistsVC.view.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        playlistsVC.didMove(toParent: self)
        
        addChild(albumVC)
        scrollView.addSubview(albumVC.view)
        albumVC.view.frame = CGRect(x: view.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        albumVC.didMove(toParent: self)
    }
}

// MARK: - Scroll View Delegate

extension LibraryViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= (view.width - 100) {
            toggleView.update(for: .albums)
            updateBarButtons()
        } else {
            toggleView.update(for: .playlists)
            updateBarButtons()
        }
    }
}

// MARK: - Toggle View Delegate

extension LibraryViewController: LibraryToggleViewDelegate {
    
    func libraryToggleViewDidTapPlaylists(_ libraryToggleView: LibraryToggleView) {
        scrollView.setContentOffset(.zero, animated: true)
        updateBarButtons()
    }
    func libraryToggleViewDidTapAlbums(_ libraryToggleView: LibraryToggleView) {
        scrollView.setContentOffset(CGPoint(x: view.width, y: 0), animated: true)
        updateBarButtons()
    }
}
