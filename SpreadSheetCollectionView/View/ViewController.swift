//
//  ViewController.swift
//  SpreadSheetCollectionView
//
//  Created by Sam Lee iMac24 on 2024/4/2.
//

import UIKit

class ViewController: UIViewController {
    
    struct Constants {
        static let itemSize = CGSize(width: 44, height: 60)
        static let rowCount = 20
        static let fixRowWidth = itemSize.width * CGFloat(rowCount)
        static let columnCount = 30
        static let fixColumnHeight = itemSize.height * CGFloat(columnCount)
    }

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = createLayout()
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: { (_, _) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(Constants.itemSize.width),
                                                  heightDimension: .absolute(Constants.itemSize.height))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(Constants.fixRowWidth),
                                                  heightDimension: .absolute(Constants.fixColumnHeight))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
        })
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(Constants.columnCount * Constants.rowCount)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1.0
        return cell
    }
    
}
