//
//  NetworkManager.swift
//  HomeTheme
//
//  Created by Trent Guillory on 10/1/20.
//

import Foundation
import SwiftUI

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

    func testGetThemes() -> [Theme] {
        let iconAssets = [Asset(name: "Safari", altText: "", image: Image("safari")),
                          Asset(name: "Find My", altText: "", image: Image("find-my")),
                          Asset(name: "Firefox", altText: "", image: Image("firefox")),
                          Asset(name: "Siri", altText: "", image: Image("siri")),
                          Asset(name: "Telegram", altText: "", image: Image("telegram")),
                          Asset(name: "Symbols", altText: "", image: Image("symbols")),
                          Asset(name: "Spotify", altText: "", image: Image("spotify")),
                          Asset(name: "Messages", altText: "", image: Image("messages"))]
        let backgroundImg = Asset(name: "Background", altText: "", image: Image("background"))

        var theme = Theme(icons: iconAssets, widgetPhotos: [], backgrounds: [backgroundImg], previews: [])
        var theme2 = theme
        var theme3 = theme
        var theme4 = theme

        theme2.id = 2
        theme3.id = 3
        theme4.id = 4

        return [theme, theme2, theme3, theme4]
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
