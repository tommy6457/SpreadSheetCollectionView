//
//  ViewController.swift
//  SpreadSheetCollectionView
//
//  Created by Sam Lee iMac24 on 2024/4/2.
//

import UIKit

class ViewController: UIViewController {
    
    struct Constants {
        static let itemSize = CGSize(width: 100, height: 44)
        static let rowCount = 10
        static let fixRowWidth = itemSize.width * CGFloat(rowCount)
        static let columnCount = 5
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
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.resuseID)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: { (_, _) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(Constants.itemSize.width),
                                                  heightDimension: .absolute(Constants.itemSize.height))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let subgroupSize = NSCollectionLayoutSize(widthDimension: .absolute(Constants.fixRowWidth),
                                                      heightDimension: .absolute(Constants.itemSize.height))
            var subgroups = [NSCollectionLayoutGroup]()
            for _ in 0..<Constants.columnCount {
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: subgroupSize, subitems: [item])
                subgroups.append(group)
            }
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(Constants.fixRowWidth),
                                                  heightDimension: .absolute(Constants.fixColumnHeight))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: subgroups)
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            return section
        })
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(Constants.columnCount * Constants.rowCount)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.resuseID, for: indexPath) as? ItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.fill(indexpath: indexPath)
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1.0
        return cell
    }
    
}
