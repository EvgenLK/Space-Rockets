//
//  TableViewModelLaunchesType.swift
//  SpaceRockets
//
//  Created by Evgenii Kutasov on 06.08.2023.
//

import Foundation

protocol TableViewModelLaunchesType: AnyObject {
    var name: String { get }
    var date: String { get }
    var image: String? { get }
}
