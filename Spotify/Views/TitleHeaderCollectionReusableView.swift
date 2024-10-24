//
//  TitleHeaderCollectionReusableView.swift
//  Spotify
//
//  Created by Pavel Maal on 22.10.24.
//

import UIKit

class TitleHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "TitleHeaderCollectionReusableView"
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        configurePositionOfSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String) {
        label.text = title
    }
    
    // MARK: - Position of subviews
    
    private func configurePositionOfSubviews() {
        self.addSubview(label)
        label.frame = CGRect(x: 20, y: 0, width: width - 30, height: height)
    }
}
