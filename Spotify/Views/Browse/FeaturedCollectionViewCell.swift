//
//  FeaturedCollectionViewCell.swift
//  Spotify
//
//  Created by Pavel Maal on 26.09.24.
//

import UIKit

class FeaturedCollectionViewCell: UICollectionViewCell {
    static let identifier = "FeaturedCollectionViewCell"
    
    private let playlistCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.image = UIImage(systemName: "photo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let playlistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let creatorNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpPositionOfSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playlistNameLabel.text = nil
        creatorNameLabel.text = nil
        playlistCoverImageView.image = nil
    }
    
    func configure(with viewModel: FeaturedPlaylistCellViewModel) {
        playlistNameLabel.text = viewModel.name
        creatorNameLabel.text = viewModel.creatorName
        playlistCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
    
    private func setUpPositionOfSubviews() {
        self.addSubview(playlistCoverImageView)
        self.addSubview(playlistNameLabel)
        self.addSubview(creatorNameLabel)
        
        let imageSize = UIScreen.main.bounds.width/3
        
        NSLayoutConstraint.activate([
            playlistCoverImageView.topAnchor.constraint(
                equalTo: self.topAnchor, constant: 5),
            playlistCoverImageView.centerXAnchor.constraint(
                equalTo: self.centerXAnchor),
            playlistCoverImageView.heightAnchor.constraint(equalToConstant: imageSize),
            playlistCoverImageView.widthAnchor.constraint(equalToConstant: imageSize),
            
            playlistNameLabel.topAnchor.constraint(
                equalTo: playlistCoverImageView.bottomAnchor, constant: 5),
            playlistNameLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor, constant: 5),
            playlistNameLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor, constant: -5),
            
            creatorNameLabel.topAnchor.constraint(
                equalTo: playlistNameLabel.bottomAnchor, constant: 5),
            creatorNameLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor, constant: 5),
            creatorNameLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor, constant: -5)
        ])
    }
}
