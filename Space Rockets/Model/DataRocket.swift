//
//  SpaceData.swift
//  Space Rockets
//
//  Created by Evgenii Kutasov on 11.07.2023.
//

import Foundation

struct dataRocket {
    let imageView: String
    let name: String
}

extension dataRocket {
    struct ParamRocket {
        let height: String
        let diameter: String
        let weight: String
        let leo: String
    }
}

extension dataRocket {
    struct infoRocket {
        let dateOneStart: String
        let country: String
        let startupCost: String
        let firstStageNumberOfEngines: String
        let firstStageQuantitOfFuelInTons: String
        let firstStageBurnTimeInSeconds: String
        let secondStageNumberOfEngines: String
        let secondStageQuantitOfFuelInTons: String
        let secondStageBurnTimeInSeconds: String
    }
}
