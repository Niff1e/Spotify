//
//  AlbumTrackCollectionViewCell.swift
//  Spotify
//
//  Created by Pavel Maal on 24.10.24.
//

import UIKit

class AlbumTrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "AlbumTrackCollectionViewCell"
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
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
    }
    
    func configure(with viewModel: AlbumCollectionViewCellViewModel) {
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
    }
    
    private func setUpPositionOfSubviews() {
        self.addSubview(trackNameLabel)
        self.addSubview(artistNameLabel)
        
        let imageSize = UIScreen.main.bounds.width/8
        
        NSLayoutConstraint.activate([
            trackNameLabel.topAnchor.constraint(
                equalTo: self.topAnchor, constant: 5),
            trackNameLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor, constant: 5),
            trackNameLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor, constant: -5),

            artistNameLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor, constant: 5),
            artistNameLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor, constant: -5),
            artistNameLabel.bottomAnchor.constraint(
                equalTo: self.bottomAnchor, constant: -5)
        ])
    }
}
