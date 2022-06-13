//
//  NetworkService.swift
//  GoraTT (AppNews)
//
//  Created by Vadim Voronkov on 11.06.2022.
//

import Foundation

class APICaller {
    
    static let shared = APICaller()
    
    let url = URL(string: API.US)
    
    public func getData(completion: @escaping completion) {
        guard let url = url else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
