//
//  ViewController.swift
//  GoraTT (AppNews)
//
//  Created by Vadim Voronkov on 11.06.2022.
//

import UIKit
import SnapKit

struct CellViewModel {
    let title: String
    let urlToImage: String
}

class MainScreenVC: UIViewController {
    
    private var cellModel = [CellViewModel]()
    
    private var collectionView: UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        
        APICaller.shared.getData { result in
            switch result {
            case .success(let response):
                self.cellModel = response.articles.compactMap({
                    CellViewModel(title: $0.title, urlToImage: $0.urlToImage ?? "")
                })
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                print(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.createUI()
    }
    
    func createUI() {
        self.view.addSubview(self.collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }


}




extension MainScreenVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        return cell
    }
    
}
