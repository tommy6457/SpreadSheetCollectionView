//
//  StickyVCollectionReusableView.swift
//  SpreadSheetCollectionView
//
//  Created by Sam Lee iMac24 on 2024/4/3.
//

import UIKit

class StickyVCollectionReusableView: UICollectionReusableView {
    
    static let reuseID = "stickyVCollectionReusableView"
    static let elementKind = "sticky-header-V"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(rowCount: Int, cellSize: CGSize) {
        
        var x = cellSize.width
        
        for i in 0..<rowCount {
            let frame = CGRect(origin: .init(x: x, y: 0),
                               size: cellSize)
            let label = UILabel(frame: frame)
            addSubview(label)
            label.text = "row: \(i)"
            label.textAlignment = .center
            label.backgroundColor = .lightGray
            label.layer.borderColor = UIColor.black.cgColor
            label.layer.borderWidth = 1.0
            x += cellSize.width
        }
    }
}
