//
//  ColorViewCell.swift
//  Tracker
//
//  Created by Андрей Грошев on 25.05.2026.
//

import UIKit

final class ColorViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ColorCell"
    
    private let colorView = UIView()
    private let selectionBorderView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        selectionBorderView.layer.borderColor = UIColor.clear.cgColor
    }
    
    private func configureUI() {
        colorView.layer.cornerRadius = 12
        colorView.layer.masksToBounds = true
        
        selectionBorderView.layer.cornerRadius = 16
        selectionBorderView.layer.borderWidth = 2
        selectionBorderView.layer.borderColor = UIColor.clear.cgColor
        selectionBorderView.backgroundColor = .clear
        
        contentView.addSubview(selectionBorderView)
        selectionBorderView.addSubview(colorView)
        
        colorView.translatesAutoresizingMaskIntoConstraints = false
        selectionBorderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            selectionBorderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            selectionBorderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            selectionBorderView.topAnchor.constraint(equalTo: contentView.topAnchor),
            selectionBorderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            colorView.leadingAnchor.constraint(equalTo: selectionBorderView.leadingAnchor, constant: 6),
            colorView.trailingAnchor.constraint(equalTo: selectionBorderView.trailingAnchor, constant: -6),
            colorView.topAnchor.constraint(equalTo: selectionBorderView.topAnchor, constant: 6),
            colorView.bottomAnchor.constraint(equalTo: selectionBorderView.bottomAnchor, constant: -6)
        ])
    }
    
    func configure(with color: UIColor, isSelected: Bool) {
        colorView.backgroundColor = color
        
        colorView.backgroundColor = color
        selectionBorderView.layer.borderColor = isSelected ? color.cgColor : UIColor.clear.cgColor
    }
}
