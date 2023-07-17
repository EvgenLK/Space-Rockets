//
//  ViewModelInfoRocket.swift
//  SpaceRockets
//
//  Created by Evgenii Kutasov on 16.07.2023.
//

import Foundation

class ViewModelInfoRocket {
    
    let infoRocket = InfoRocket(dateOneStart: "05 12 1993", country: "11111", startupCost: "1111", firstStageNumberOfEngines: "11111", firstStageQuantitOfFuelInTons: "1111", firstStageBurnTimeInSeconds: "1111", secondStageNumberOfEngines: "1111", secondStageQuantitOfFuelInTons: "11111", secondStageBurnTimeInSeconds: "11111")
    

    var dateOneStart: String {
        return infoRocket.dateOneStart
    }
    
    var country: String {
        return infoRocket.country
    }
    
    var startupCost: String {
        return infoRocket.startupCost
    }
    
    var firstStageNumberOfEngines: String {
        return infoRocket.firstStageNumberOfEngines
    }
    
    var firstStageQuantitOfFuelInTons: String {
        return infoRocket.firstStageQuantitOfFuelInTons
    }
    
    var firstStageBurnTimeInSeconds: String {
        return infoRocket.firstStageBurnTimeInSeconds
    }
    
    var secondStageNumberOfEngines: String {
        return infoRocket.secondStageNumberOfEngines
    }
    
    var secondStageQuantitOfFuelInTons: String {
        return infoRocket.secondStageQuantitOfFuelInTons
    }
    
    var secondStageBurnTimeInSeconds: String {
        return infoRocket.secondStageBurnTimeInSeconds
    }
}
