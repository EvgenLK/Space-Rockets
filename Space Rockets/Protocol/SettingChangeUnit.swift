//
//  SettingChangeUnit.swift
//  SpaceRockets
//
//  Created by Evgenii Kutasov on 10.08.2023.
//

import Foundation

protocol SettingViewParamRocketDelegate: AnyObject {
    func didUpdateRocketParameters(height: Int, diameter: Int, mass: Int, leo: Int)
}

