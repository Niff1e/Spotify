//
//  RecommendedTrackCollectionViewCell.swift
//  Spotify
//
//  Created by Pavel Maal on 26.09.24.
//

import UIKit

class RecommendedTrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecommendedTrackCollectionViewCell"
    
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.image = UIImage(systemName: "photo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        setUpPositionOfSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text = nil
        artistNameLabel.text = nil
        albumCoverImageView.image = nil
    }
    
    func configure(with viewModel: RecommendedTrackCellViewModel) {
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        albumCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
    
    private func setUpPositionOfSubviews() {
        self.addSubview(albumCoverImageView)
        self.addSubview(trackNameLabel)
        self.addSubview(artistNameLabel)
        
        let imageSize = UIScreen.main.bounds.width/5
        
        NSLayoutConstraint.activate([
            albumCoverImageView.topAnchor.constraint(
                equalTo: self.topAnchor, constant: 5),
            albumCoverImageView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor, constant: 5),
            albumCoverImageView.widthAnchor.constraint(equalToConstant: imageSize),
            albumCoverImageView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor, constant: -5),

            trackNameLabel.topAnchor.constraint(
                equalTo: self.topAnchor, constant: 5),
            trackNameLabel.leadingAnchor.constraint(
                equalTo: albumCoverImageView.trailingAnchor, constant: 5),
            trackNameLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor, constant: -5),

            
            artistNameLabel.leadingAnchor.constraint(
                equalTo: albumCoverImageView.trailingAnchor, constant: 5),
            artistNameLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor, constant: -5),
            artistNameLabel.bottomAnchor.constraint(
                equalTo: self.bottomAnchor, constant: -5)
        ])
    }
}
