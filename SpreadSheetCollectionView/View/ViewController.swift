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
        static let columnCount = 20
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
        collectionView.register(StickyHCollectionReusableView.self, forSupplementaryViewOfKind: StickyHCollectionReusableView.elementKind, withReuseIdentifier: StickyHCollectionReusableView.reuseID)
        collectionView.register(StickyVCollectionReusableView.self, forSupplementaryViewOfKind: StickyVCollectionReusableView.elementKind, withReuseIdentifier: StickyVCollectionReusableView.reuseID)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "reuse-header")
    }
    
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: { (_, _) -> NSCollectionLayoutSection? in
            //header
            //horizontal
            let stickyHHeaderSize = NSCollectionLayoutSize(widthDimension: .absolute(Constants.itemSize.width),
                                                          heightDimension: .absolute(Constants.fixColumnHeight + Constants.itemSize.height))
            let stickyHHeaderItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: stickyHHeaderSize,
                                                                      elementKind: StickyHCollectionReusableView.elementKind,
                                                                      alignment: .leading)
            stickyHHeaderItem.pinToVisibleBounds = true
            //vertical
            let stickyVHeaderSize = NSCollectionLayoutSize(widthDimension: .absolute(Constants.fixRowWidth + Constants.itemSize.width),
                                                          heightDimension: .absolute(Constants.itemSize.height))
            let stickyVHeaderItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: stickyVHeaderSize,
                                                                      elementKind: StickyVCollectionReusableView.elementKind,
                                                                      alignment: .topLeading)
            stickyVHeaderItem.pinToVisibleBounds = true
            //item
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(Constants.itemSize.width),
                                                  heightDimension: .absolute(Constants.itemSize.height))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let subgroupSize = NSCollectionLayoutSize(widthDimension: .absolute(Constants.fixRowWidth + Constants.itemSize.width),
                                                      heightDimension: .absolute(Constants.itemSize.height))
            var subgroups = [NSCollectionLayoutGroup]()
            for _ in 0..<Constants.columnCount {
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: subgroupSize, subitems: [item])
                group.contentInsets = .init(top: 0, leading: Constants.itemSize.width, bottom: 0, trailing: 0)
                subgroups.append(group)
            }
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(Constants.fixRowWidth + Constants.itemSize.width),
                                                  heightDimension: .absolute(Constants.fixColumnHeight + Constants.itemSize.height))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: subgroups)
            //固定上方Header，不固定左方Header
            group.supplementaryItems = [stickyHHeaderItem]
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.boundarySupplementaryItems = [stickyVHeaderItem]
            //固定左、右方Header
//            let section = NSCollectionLayoutSection(group: group)
//            section.orthogonalScrollingBehavior = .continuous
//            section.boundarySupplementaryItems = [stickyHHeaderItem,stickyVHeaderItem]
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case StickyHCollectionReusableView.elementKind:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: StickyHCollectionReusableView.elementKind,
                                                                         withReuseIdentifier: StickyHCollectionReusableView.reuseID,
                                                                         for: indexPath) as! StickyHCollectionReusableView
            header.configure(columnCount: Constants.columnCount, cellSize: Constants.itemSize)
            return header
        case StickyVCollectionReusableView.elementKind:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: StickyVCollectionReusableView.elementKind,
                                                                         withReuseIdentifier: StickyVCollectionReusableView.reuseID,
                                                                         for: indexPath) as! StickyVCollectionReusableView
            header.configure(rowCount: Constants.rowCount, cellSize: Constants.itemSize)
            return header
        default:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: "reuse-header",
                                                                         for: indexPath)
            return header
        }
    }
    
}
