//
//  SearchResultSubtitleTableViewCell.swift
//  Spotify
//
//  Created by Pavel Maal on 1.11.24.
//

import UIKit
import SDWebImage

class SearchResultSubtitleTableViewCell: UITableViewCell {
    
    static let identifier: String = "SearchResultSubtitleTableViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Configurind with view model
    
    func configure(with viewModel: SearchResultSubtitleTableViewCellViewModel) {
        label.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        iconImage.sd_setImage(with: viewModel.imageURL, placeholderImage: UIImage(systemName: "photo"), completed: nil)
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupPositionOfSubviews()
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImage.image = nil
        label.text = nil
        subtitleLabel.text = nil
    }
    
    // MARK: - Position of subviews
    
    private func setupPositionOfSubviews() {
        contentView.addSubview(label)
        contentView.addSubview(iconImage)
        contentView.addSubview(subtitleLabel)
        
        let imageSize = contentView.height - 10
        let labelHeight = contentView.height / 2
        
        NSLayoutConstraint.activate([
            iconImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0),
            iconImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5.0),
            iconImage.widthAnchor.constraint(equalToConstant: imageSize),
            iconImage.heightAnchor.constraint(equalToConstant: imageSize),
            
            label.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 15.0),
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15.0),
            label.heightAnchor.constraint(equalToConstant: labelHeight),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 15.0),
            subtitleLabel.topAnchor.constraint(equalTo: label.bottomAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15.0),
            subtitleLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
    }
}
