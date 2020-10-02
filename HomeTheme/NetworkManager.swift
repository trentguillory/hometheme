//
//  NetworkManager.swift
//  HomeTheme
//
//  Created by Trent Guillory on 10/1/20.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    // Observed Objects
    //var themesViewModel: ThemesViewModel
    
    // HOST
    static let scheme = "http"
    static let host = "192.168.0.127"
    
    // ENDPOINTS
    static let themesPath = "/themes"
    var themesURL: URL? {
        NetworkManager.urlForPath(path: NetworkManager.themesPath)
    }
    
//    private init() {
//        themesViewModel = ThemesViewModel()
//
//
//        self.getThemes() { themes in
//            DispatchQueue.main.async {
//                self.themesViewModel.themes = themes
//            }
//        }
//    }
    
    private func request(url: URL?, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = url else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            }
        }
        
        task.resume()
    }
    
    func getThemes(completion: @escaping ([Theme]) -> Void) {
        
        request(url: themesURL) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                if let themes = try? decoder.decode([Theme].self, from: data) {
                    completion(themes)
                } else {
                    print("Can't decode.")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Helper functions
extension NetworkManager {
    static func urlForPath(path: String) -> URL? {
        var components = URLComponents()
        components.scheme = NetworkManager.scheme
        components.host = NetworkManager.host
        components.port = 1337
        components.path = path
        
        return components.url
    }
}