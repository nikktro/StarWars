//
//  NetworkManager.swift
//  StarWars
//
//  Created by Nikolay Trofimov on 07.06.2023.
//

import Foundation

class NetworkManager {

  static let shared = NetworkManager()

  func fetchData<T:Decodable>(from url: String?, dataType: T.Type, completion: @escaping(T) -> Void) {
    guard let stringURL = url else { return }
    guard let url = URL(string: stringURL)?.setScheme("https") else { return }

    URLSession.shared.dataTask(with: url) { data, _, error in
      guard let data = data else {
        print(error?.localizedDescription ?? "No error description")
        return
      }

      do {
        let type = try JSONDecoder().decode(T.self, from: data)
        DispatchQueue.main.async {
          completion(type)
        }
      } catch let error {
        print(error.localizedDescription)
      }
    }.resume()
  }

  private init() {}

}

extension URL {
  func setScheme(_ value: String) -> URL? {
    let components = NSURLComponents.init(url: self, resolvingAgainstBaseURL: true)
    components?.scheme = value
    return components?.url
  }
}
