//
//  ParametrRocketUnit.swift
//  SpaceRockets
//
//  Created by Evgenii Kutasov on 10.08.2023.
//

import Foundation


enum HeightUnit: Int {
    case m = 0, ft
    func description(for value: Int) -> String {
        switch value {
        case HeightUnit.m.rawValue:
            return "m"
        case HeightUnit.ft.rawValue:
            return "ft"
        default:
            return "unknown unit"
        }
    }
}

enum DiameterUnit: Int {
    case m = 0, ft
    func description(for value: Int) -> String {
        switch value {
        case DiameterUnit.m.rawValue:
            return "m"
        case DiameterUnit.ft.rawValue:
            return "ft"
        default:
            return "unknown unit"
            
        }
    }
}

enum WeightUnit: Int {
    case kg = 0, lb
    func description(for value: Int) -> String {
        switch value {
        case WeightUnit.kg.rawValue:
            return "kg"
        case WeightUnit.lb.rawValue:
            return "lb"
        default:
            return "unknown unit"
            
        }
    }
}

enum LeoUnit: Int {
    case kg = 0, lb
    func description(for value: Int) -> String {
        switch value {
        case LeoUnit.kg.rawValue:
            return "kg"
        case LeoUnit.lb.rawValue:
            return "lb"
        default:
            return "unknown unit"
            
        }
    }
}
