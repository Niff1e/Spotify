//
//  SearchResultDefaultTableViewCell.swift
//  Spotify
//
//  Created by Pavel Maal on 31.10.24.
//

import UIKit

class SearchResultDefaultTableViewCell: UITableViewCell {
    
    static let identifier: String = "SearchResultDefaultTableViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
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
    
    func configure(with viewModel: SearchResultDefaultTableViewCellViewModel) {
        label.text = viewModel.title
        iconImage.sd_setImage(with: viewModel.imageURL, completed: nil)
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
    }
    
    // MARK: - Position of subviews
    
    private func setupPositionOfSubviews() {
        contentView.addSubview(label)
        contentView.addSubview(iconImage)
        let imageSize = contentView.height - 10
        iconImage.layer.cornerRadius = imageSize / 2
        iconImage.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            iconImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0),
            iconImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5.0),
            iconImage.widthAnchor.constraint(equalToConstant: imageSize),
            iconImage.heightAnchor.constraint(equalToConstant: imageSize),
            
            label.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 10.0),
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15.0),
            label.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
}
