//
//  EmojiViewCell.swift
//  Tracker
//
//  Created by Андрей Грошев on 25.05.2026.
//

import UIKit

final class EmojiViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "EmojiCell"
    
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.backgroundColor = .clear
    }
    
    private func configureUI() {
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        
        label.font = .systemFont(ofSize: 32)
        label.textAlignment = .center
        
        contentView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(with emoji: String, isSelected: Bool) {
        label.text = emoji
        
        contentView.backgroundColor = isSelected ? UIColor.systemGray5 : .clear
    }
}
