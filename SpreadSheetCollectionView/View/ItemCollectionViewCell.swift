//
//  ItemCollectionViewCell.swift
//  SpreadSheetCollectionView
//
//  Created by Sam Lee iMac24 on 2024/4/2.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    static let resuseID = "itemCollectionViewCell"
    
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(indexpath: IndexPath) {
        label.text = "row\(indexpath.row)"
    }
    
    private func configure() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
        label.textAlignment = .center
    }
    
}
