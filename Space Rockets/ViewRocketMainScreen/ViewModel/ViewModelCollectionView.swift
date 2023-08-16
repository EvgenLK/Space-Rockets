//
//  ViewModelCollectionView.swift
//  SpaceRockets
//
//  Created by Evgenii Kutasov on 25.07.2023.
//

import Foundation

class ViewModelCollectionView: CollectionViewModel {
    
    let viewModelResponse = NetworkRocketResponse()
    private var rocketParam = [SpaceDatumRocket]()
    var rocketParamData = [DataRocket.ParamRocket]()
    
    var currentHeightUnit: HeightUnit = .m
    var currentWeightUnit: WeightUnit = .kg
    var currentDiameterUnit: DiameterUnit = .m
    var currentLeoUnit: LeoUnit = .kg
    

    init() {
        fetchRocketData()
    }

    private func fetchRocketData() {
        viewModelResponse.getDataRocketNetwork { json in
            self.rocketParam = json
        }
    }
    
    func processJSONData() {
        self.rocketParamData.removeAll()
        for rocketData in self.rocketParam {
            var heightValue: String
            var weightValue: String
            var diameterValue: String
            var leoValue: String
            
            switch currentHeightUnit {
            case .ft:
                heightValue = "\(rocketData.height.feet ?? 0)"
            case .m:
                heightValue = "\(rocketData.height.meters ?? 0)"
            }
            
            switch currentDiameterUnit {
            case .ft:
                diameterValue = "\(rocketData.diameter.feet ?? 0)"
            case .m:
                diameterValue = "\(rocketData.diameter.meters ?? 0)"
            }
            
            switch currentWeightUnit {
            case .kg:
                weightValue = "\(rocketData.mass.kg)"
            case .lb:
                weightValue = "\(rocketData.mass.lb)"
            }
            
            switch currentLeoUnit {
            case .kg:
                leoValue = "\(rocketData.payloadWeights[0].kg)"
            case .lb:
                leoValue = "\(rocketData.payloadWeights[0].lb)"
            }
            
            let rocketParametr = DataRocket.ParamRocket(height: heightValue, diameter: diameterValue, weight: weightValue, leo: leoValue)
            rocketParamData.append(rocketParametr)
        }
    }
    
    func getRocketDataParametr() -> [DataRocket.ParamRocket] {
        return rocketParamData
    }

    func numberOfRows() -> Int {
        return rocketParamData.count
    }

}

