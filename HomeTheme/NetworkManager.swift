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
    static let scheme = "https"
    static let host = "hometheme.cdn.prismic.io"
    
    // ENDPOINTS
    static let themesPath = "/api/v2/documents/search"
    var themesURL: URL? {
        return NetworkManager.urlForPath(path: NetworkManager.themesPath)
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

                let json = String(data: data, encoding: String.Encoding.utf8)
                print("Response: \(json)")

                let decoder = JSONDecoder()
                if let page = try? decoder.decode(Page<Theme>.self, from: data) {
                    completion(page.results)
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
        components.path = path
        components.queryItems = [URLQueryItem(name: "q", value: "[[at(document.type,\"theme\")]]"),
                                 URLQueryItem(name: "ref", value: "X3zuYhUAACcAiPZD"),
                                 URLQueryItem(name: "access_token", value: "MC5YM3oxNEJVQUFDb0FpUmdI.77-977-977-977-977-9J1jvv70R77-977-9bhPvv73vv70R77-977-977-9MAfvv73vv70bYhhY77-9Nnthag")]

        return components.url
    }
}
