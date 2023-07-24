//
//  NetworkRocketResponse.swift
//  SpaceRockets
//
//  Created by Evgenii Kutasov on 24.07.2023.
//

import Foundation

class NetworkRocketResponse {
    
    public func getDataRocketNetwork(completion: @escaping (Any) -> Void) {
        guard let url = URL(string: "https://api.spacexdata.com/v4/rockets") else { return }
                                
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Ошибка при получении данных: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Данные не получены.")
                return
            }
            
            do {
                let json = try JSONDecoder().decode([SpaceDatumRocket].self, from: data)
                DispatchQueue.main.async {
                    completion(json)
                }
            } catch {
                print("Ошибка при декодировании JSON: \(error.localizedDescription)")
            }
        }.resume()
    }

}
