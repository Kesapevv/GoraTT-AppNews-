//
//  CollectionView++.swift
//  GoraTT (AppNews)
//
//  Created by Vadim Voronkov on 14.06.2022.
//

import Foundation
import UIKit
import SafariServices

extension MainScreenVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionReusableView.headerIdentifier, for: indexPath) as? CollectionReusableView
        header?.configure(headerLabel: "USA")
        return header!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 20, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectRow(at: indexPath, animated: true)
        let urls = cellModel[indexPath.row]
        guard let url = URL(string: urls.url ?? "") else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
}
