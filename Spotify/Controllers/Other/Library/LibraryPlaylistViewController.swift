//
//  LibraryPlaylistViewController.swift
//  Spotify
//
//  Created by Pavel Maal on 19.11.24.
//

import UIKit

class LibraryPlaylistViewController: UIViewController {
    
    var playlists = [LibraryPlaylist]()
    
    public var selectionHandler: ((Playlist) -> Void)?
    
    private let noPlaylistsView = ActionLabelView()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SearchResultSubtitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifier)
        tableView.isHidden = true
        return tableView
    }()
    
    // MARK: - VC Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        view.addSubview(noPlaylistsView)
        configurePositionOfSubviews()
        
        setUpNoPlaylistsView()
        
        fetchData()
        
        if selectionHandler != nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        }
    }
    
    // MARK: - Objc
    
    @objc func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Subviews
    
    private func configurePositionOfSubviews() {
        view.addSubview(noPlaylistsView)
        view.addSubview(tableView)
        tableView.frame = view.bounds
        noPlaylistsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            noPlaylistsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noPlaylistsView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            noPlaylistsView.widthAnchor.constraint(equalToConstant: 150),
            noPlaylistsView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setUpNoPlaylistsView() {
        noPlaylistsView.delegate = self
        noPlaylistsView.configure(with: ActionLabelViewViewModel(text: "You don't have any playlists yet.", actionTitle: "Create"))
    }
    
    private func updateUI() {
        if playlists.isEmpty {
            noPlaylistsView.isHidden = false
            tableView.isHidden = true
        } else {
            tableView.reloadData()
            noPlaylistsView.isHidden = true
            tableView.isHidden = false
        }
    }
    
    // MARK: - Playlists data logic
    
    private func fetchData() {
        APICaller.shared.getCurrentUserPlaylist { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let playlists):
                    self?.playlists = playlists
                    self?.updateUI()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    public func showCreatePlaylistAlert() {
        let alert = UIAlertController(title: "New Playlist", message: "Enter Playlist Name", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Playlist..."
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { _ in
            guard let field = alert.textFields?.first,
                  let text = field.text,
                  !text.trimmingCharacters(in: .whitespaces).isEmpty else {
                return
            }
            
            APICaller.shared.createPlaylist(with: text) { [weak self] success in
                if success {
                    self?.fetchData()
                } else {
                    print("Failed to create playlist")
                }
            }
        }))
        
        present(alert, animated: true)
    }
}

// MARK: - Action Label View Delegate

extension LibraryPlaylistViewController: ActionLabelViewDelegate {
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        showCreatePlaylistAlert()
    }
}

// MARK: - TableView Delegate and DataSource

extension LibraryPlaylistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchResultSubtitleTableViewCell.identifier,
            for: indexPath
        ) as? SearchResultSubtitleTableViewCell else {
                return UITableViewCell()
        }
        let playlist = playlists[indexPath.row]
        
        cell.configure(
            with: SearchResultSubtitleTableViewCellViewModel(
                title: playlist.name,
                subtitle: playlist.owner.display_name,
                imageURL: URL(string: playlist.images?.first?.url ?? "")
            )
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let libraryPlaylist = playlists[indexPath.row]
        let playlist = Playlist(description: "", external_urls: libraryPlaylist.external_urls, id: libraryPlaylist.id, images: libraryPlaylist.images ?? [], name: libraryPlaylist.name, owner: libraryPlaylist.owner)
        
        guard selectionHandler == nil else {
            selectionHandler?(playlist)
            dismiss(animated: true, completion: nil)
            return
        }
        
        let vc = PlaylistViewController(playlist: playlist)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
