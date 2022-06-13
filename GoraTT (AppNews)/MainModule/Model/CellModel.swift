//
//  CellModel.swift
//  GoraTT (AppNews)
//
//  Created by Vadim Voronkov on 13.06.2022.
//

import Foundation

class CellViewModel {
    
    let title: String
    let urlToImage: String?
    var url: String?
    var imageData: Data? = nil
    
    init(title: String, urlToImage: String, url: String) {
        self.title = title
        self.urlToImage = urlToImage
        self.url = url
    }
    
}
