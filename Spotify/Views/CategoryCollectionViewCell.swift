//
//  GenreCollectionViewCell.swift
//  Spotify
//
//  Created by Pavel Maal on 25.10.24.
//

import UIKit
import SDWebImage

class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "GenreCollectionViewCell"
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(
            systemName: "music.quarternote.3",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: 50,
                weight: .regular
            )
        )
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 22,  weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let colors: [UIColor] = [
        .systemPink,
        .systemBlue,
        .systemPurple,
        .systemGreen,
        .systemOrange,
        .systemYellow,
        .systemRed,
        .systemGray,
        .systemTeal
    ]
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        configurePositionOfSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        imageView.image = UIImage(
            systemName: "music.quarternote.3",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: 50,
                weight: .regular
            )
        )
    }
    
    func configure(with viewModel: CategoryCollectionViewCellViewModel) {
        label.text = viewModel.title
        imageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
        contentView.backgroundColor = colors.randomElement()
    }
    
    private func configurePositionOfSubviews() {
        self.addSubview(imageView)
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            label.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5)
        ])
    }
}
