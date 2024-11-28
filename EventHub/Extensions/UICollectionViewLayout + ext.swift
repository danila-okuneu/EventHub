//
//  UICollectionViewLayout + ext.swift
//  EventHub
//
//  Created by Igor Guryan on 17.11.2024.
//

import UIKit.UICollectionViewLayout

extension UICollectionViewLayout {
    static func eventsLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch ExploreSection(rawValue: sectionIndex)
            {
            case .search:
                return createSearchSection()
            case .categories:
                return createCategorySection()
            case .upcoming, .nearby:
                return createOrthogonalSection()
            default:
                return nil
            }
        }
        return layout
    }
    
    private static func createSearchSection() -> NSCollectionLayoutSection {
        let estimatedHeight: CGFloat = 132
//        let estimatedWidth: CGFloat = 86
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                          heightDimension: .estimated(estimatedHeight))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
//        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
//                let header = createHeader()
//                section.boundarySupplementaryItems = [header]
        return section
    }
    
    private static func createCategorySection() -> NSCollectionLayoutSection {
        let estimatedHeight: CGFloat = 40
        let estimatedWidth: CGFloat = 140
        let size = NSCollectionLayoutSize(widthDimension: .estimated(estimatedWidth),
                                          heightDimension: .estimated(estimatedHeight))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 12)
        
        //        let header = createHeader()
        //        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private static func createOrthogonalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(237), heightDimension: .absolute(255))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 12.0, leading: 24, bottom: 12, trailing: 12.0)
		section.orthogonalScrollingBehavior = .continuous
        let header = createHeader()
        section.boundarySupplementaryItems = [header]
        return section
    }
    
//    private static func createRecommendedFromCategorySection() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(96))
//        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
//        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets(top: 12.0, leading: 12.0, bottom: 12.0, trailing: 12.0)
//        section.interGroupSpacing = 8
//        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
//        let header = createHeader()
//        section.boundarySupplementaryItems = [header]
//        return section
//    }
    
    private static func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(34))
        let layout = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: itemSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        return layout
    }
    
}

@available(iOS 17.0, *)
#Preview {ExploreViewController()
}
