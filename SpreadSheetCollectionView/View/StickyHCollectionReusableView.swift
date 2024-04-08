//
//  StickyHCollectionReusableView.swift
//  SpreadSheetCollectionView
//
//  Created by Sam Lee iMac24 on 2024/4/3.
//

import UIKit

class StickyHCollectionReusableView: UICollectionReusableView {
    
    static let reuseID = "stickyHCollectionReusableView"
    static let elementKind = "sticky-header-H"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(columnCount: Int, cellSize: CGSize) {
        
        var y = 0.0
        
        for i in 0..<columnCount {
            let frame = CGRect(origin: .init(x: 0, y: y),
                               size: cellSize)
            let label = UILabel(frame: frame)
            addSubview(label)
            label.text = "column: \(i)"
            label.textAlignment = .center
            label.backgroundColor = .lightGray
            label.layer.borderColor = UIColor.black.cgColor
            label.layer.borderWidth = 1.0
            y += cellSize.height
        }
    }
}
