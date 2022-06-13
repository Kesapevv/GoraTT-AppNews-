//
//  Delegate, DataSource.swift
//  GoraTT (AppNews)
//
//  Created by Vadim Voronkov on 13.06.2022.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let identifier = "CollectionViewCell"
    
    private enum Constraints {
        static let articleTitleLabelTop = 10
        static let articleTitleLabelLeading = 50
        static let articleTitleLabelTrailing = 10
        static let articleTitleLabelBottom = 10
    }
    
    //MARK: - Views
    
    private var articleTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    private var articleImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 15
        return image
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    public func configureCell(with cellViewModel: CellViewModel) {
        self.articleTitleLabel.text = cellViewModel.title
        if let data = cellViewModel.imageData {
            self.articleImage.image = UIImage(data: data)
        } else if let stringurl = cellViewModel.urlToImage, let url = URL(string: stringurl) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else { return }
                cellViewModel.imageData = data
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.articleImage.image = UIImage(data: data)
                }
            }.resume()
        }
    }
    
    private func createUI() {
        self.contentView.addSubview(self.articleImage)
        self.articleImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        self.articleImage.addSubview(self.articleTitleLabel)
        self.articleTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.safeAreaLayoutGuide).inset(Constraints.articleTitleLabelTop)
            make.leading.equalTo(self.contentView.safeAreaLayoutGuide).inset(Constraints.articleTitleLabelLeading)
            make.trailing.equalTo(self.contentView.safeAreaLayoutGuide).inset(Constraints.articleTitleLabelTrailing)
            make.bottom.equalTo(self.contentView.safeAreaLayoutGuide).inset(Constraints.articleTitleLabelBottom)
        }
    }
    
}

