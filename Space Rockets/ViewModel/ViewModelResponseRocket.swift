//
//  ViewModelResponseRocket.swift
//  SpaceRockets
//
//  Created by Evgenii Kutasov on 23.07.2023.
//

import Foundation
import UIKit

class ViewModelResponseRocket {

    private var rocketInfo: [DataRocket.InfoRocket] = []
    private var rocketParam: [DataRocket.ParamRocket] = []
    private var rocketDataData: [DataRocket] = []
    
    func processJSONData(_ jsonData: [SpaceDatumRocket]) {
        for rocketData in jsonData {
            let rocketInfoVM = DataRocket.InfoRocket(dateOneStart: "\(rocketData.firstFlight)",
                                                     country: "\(rocketData.country)",
                                                     startupCost: "\(rocketData.costPerLaunch)",
                                                     firstStageNumberOfEngines: "\(rocketData.firstStage.engines)",
                                                     firstStageQuantitOfFuelInTons: "\(rocketData.firstStage.fuelAmountTons)",
                                                     firstStageBurnTimeInSeconds: "\(rocketData.firstStage.burnTimeSEC ?? 0)",
                                                     secondStageNumberOfEngines: "\(rocketData.secondStage.engines)",
                                                     secondStageQuantitOfFuelInTons: "\(rocketData.secondStage.fuelAmountTons)",
                                                     secondStageBurnTimeInSeconds: "\(rocketData.secondStage.burnTimeSEC ?? 0)")
            rocketInfo.append(rocketInfoVM)
            
            let rocketParamVM = DataRocket.ParamRocket(height: "\(rocketData.height.meters ?? 0)",
                                                       diameter: "\(rocketData.diameter.meters ?? 0)",
                                                       weight: "\(rocketData.mass.kg)",
                                                       leo: "\(rocketData.engines.thrustSeaLevel.kN)")
            rocketParam.append(rocketParamVM)
            
            let rocketDataVM = DataRocket(name: rocketData.name)
            rocketDataData.append(rocketDataVM)
        }
    }
    
    func getRocketDataInfo() -> [DataRocket.InfoRocket] {
        return rocketInfo
    }
    func getRocketDataParam() -> [DataRocket.ParamRocket] {
        return rocketParam
    }
    func getRocketDataData() -> [DataRocket] {
        return rocketDataData
    }
    
    func getRocket(at index: Int) -> DataRocket? {
        guard index >= 0, index < rocketDataData.count else {
            return nil
        }
        return rocketDataData[index]
    }

    func getNumberOfRockets() -> Int {
        return rocketDataData.count
    }
}
    

