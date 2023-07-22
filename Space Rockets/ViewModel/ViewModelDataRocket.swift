//
//  ViewModel.swift
//  Space Rockets
//
//  Created by Evgenii Kutasov on 10.07.2023.
//

import Foundation

class ViewModelDataRocket {
    
    let dataRocket: DataRocket
    
    init(dataRocket: DataRocket) {
        self.dataRocket = dataRocket
    }

    var imageView: String? {
        return dataRocket.imageView
    }
    
    var name: String {
        return dataRocket.name
    }

}
