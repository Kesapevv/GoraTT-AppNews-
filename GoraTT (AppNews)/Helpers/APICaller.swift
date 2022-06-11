//
//  NetworkService.swift
//  GoraTT (AppNews)
//
//  Created by Vadim Voronkov on 11.06.2022.
//

import Foundation

class APICaller {
    
    static let shared = APICaller()
    
    typealias completion = ((Result<APIResponse, Error>) -> Void)
    
    let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=7cce7a190387459eb1077ac6418dc3e5")
    
    public func getData(completion: @escaping completion) {
        guard let url = url else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                print(data)
                
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("")
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
