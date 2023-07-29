//
//  DataRepository.swift
//  SpaceRockets
//
//  Created by Evgenii Kutasov on 23.07.2023.
//

import Foundation

protocol ViewCellViewModel: AnyObject {
    
    var height: String { get }
    var diametr: String { get }
    var mass: String { get }
    var leo: String { get }
}

