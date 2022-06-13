//
//  ViewController.swift
//  GoraTT (AppNews)
//
//  Created by Vadim Voronkov on 11.06.2022.
//

import UIKit
import SnapKit

class MainScreenVC: UIViewController {
    
    //MARK: - Properties
    
    var cellModel = [CellViewModel]()
    
    //MARK: - Views
    
    private var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search news"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .secondarySystemBackground
        return textField
    }()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
      //  layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self,
                                forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.register(CollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: CollectionReusableView.headerIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "News"
        self.view.backgroundColor = .systemBackground
        
        APICaller.shared.getData { result in
            switch result {
            case .success(let response):
                self.cellModel = response.articles.compactMap({
                    CellViewModel(title: $0.title,
                                  urlToImage: $0.urlToImage ?? "",
                                  url: $0.url ?? "")
                })
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.createUI()
    }
    
    //MARK: - Methods
    
    func createUI() {
        self.view.addSubview(self.textField)
        self.textField.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(20)
        }
        
        self.view.addSubview(self.collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.textField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(200)
        }
    }
    
    
}
