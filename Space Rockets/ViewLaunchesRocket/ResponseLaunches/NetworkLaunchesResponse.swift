//
//  NetworkLaunchesResponse.swift
//  SpaceRockets
//
//  Created by Evgenii Kutasov on 05.08.2023

import Foundation

class NetworkLaunchesRocket {
    
    public func getLaunchesRocketNetwork(completion: @escaping (Any) -> ()) {
        guard let url = URL(string: "https://api.spacexdata.com/v4/launches") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
                        
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                DispatchQueue.main.async {
                    completion(json)
                }
            } catch {
                print("Ошибка при декодировании JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}
