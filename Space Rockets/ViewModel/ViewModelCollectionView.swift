//
//  ViewModelCollectionView.swift
//  SpaceRockets
//
//  Created by Evgenii Kutasov on 25.07.2023.
//

import Foundation

class ViewModelCollectionView: CollectionViewModel {
    
    private var selectedIndexPath: IndexPath?
    let viewModel = ViewModelResponseRocket()
    let viewModelResponse = NetworkRocketResponse()
    private var rocketParam = [SpaceDatumRocket]()
    var rocketParamData = [DataRocket.ParamRocket]()

    init() {
        fetchRocketData()
    }

    private func fetchRocketData() {
        viewModelResponse.getDataRocketNetwork { json in
            self.rocketParam = json
        }
    }
    func processJSONData() {
         for rocketData in self.rocketParam {
             let height = "\(rocketData.height.meters ?? 0)"
             let diameter = "\(rocketData.diameter.meters ?? 0)"
             let weight = "\(rocketData.mass.kg)"
             let leo = "\(rocketData.payloadWeights[0].lb)"
             let rocketParametr = DataRocket.ParamRocket(height: height, diameter: diameter, weight: weight, leo: leo)
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

