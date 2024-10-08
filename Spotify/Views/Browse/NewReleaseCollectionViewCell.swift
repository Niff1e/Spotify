//
//  NewReleaseCollectionViewCell.swift
//  Spotify
//
//  Created by Pavel Maal on 26.09.24.
//

import UIKit
import SDWebImage

class NewReleaseCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewReleaseCollectionViewCell"
    
    private let albumsCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let numberOfTracksLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGroupedBackground
        setUpPositionOfSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumNameLabel.text = nil
        artistNameLabel.text = nil
        numberOfTracksLabel.text = nil
        albumsCoverImageView.image = nil
    }
    
    func configure(with viewModel: NewReleasesCellViewModel) {
        albumNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        numberOfTracksLabel.text = "Tracks: \(viewModel.numberOfTracks)"
        albumsCoverImageView.sd_setImage(with: viewModel.artWorkURL, completed: nil)
    }
    
    private func setUpPositionOfSubviews() {
        self.addSubview(albumsCoverImageView)
        self.addSubview(albumNameLabel)
        self.addSubview(numberOfTracksLabel)
        self.addSubview(artistNameLabel)
        
        let imageSize = UIScreen.main.bounds.width/3.5
        
        NSLayoutConstraint.activate([
            albumsCoverImageView.topAnchor.constraint(
                equalTo: self.topAnchor, constant: 5),
            albumsCoverImageView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor, constant: 5),
            albumsCoverImageView.heightAnchor.constraint(equalToConstant: imageSize),
            albumsCoverImageView.widthAnchor.constraint(equalToConstant: imageSize),
            
            albumNameLabel.topAnchor.constraint(
                equalTo: self.topAnchor, constant: 5),
            albumNameLabel.leadingAnchor.constraint(
                equalTo: albumsCoverImageView.trailingAnchor, constant: 5),
            albumNameLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor, constant: -5),
            
            artistNameLabel.topAnchor.constraint(
                equalTo: albumNameLabel.bottomAnchor, constant: 5),
            artistNameLabel.leadingAnchor.constraint(
                equalTo: albumsCoverImageView.trailingAnchor, constant: 5),
            artistNameLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor, constant: -5),
            
            numberOfTracksLabel.leadingAnchor.constraint(
                equalTo: albumsCoverImageView.trailingAnchor, constant: 5),
            numberOfTracksLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor, constant: -5),
            numberOfTracksLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
}
