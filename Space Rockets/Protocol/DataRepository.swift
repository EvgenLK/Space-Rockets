//
//  DataRepository.swift
//  SpaceRockets
//
//  Created by Evgenii Kutasov on 23.07.2023.
//

import Foundation

protocol RocketRepository {
    func getRockets(completion: @escaping (Any) -> ())
}
