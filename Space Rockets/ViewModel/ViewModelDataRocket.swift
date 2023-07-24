//
//  ViewModel.swift
//  Space Rockets
//
//  Created by Evgenii Kutasov on 10.07.2023.
//

import Foundation
import UIKit

class ViewModelDataRocket {
    
    let dataRocket: DataRocket
    
    init(dataRocket: DataRocket) {
        self.dataRocket = dataRocket
    }

    var imageView: UIImage? {
        return dataRocket.imageView
    }
    
    var name: String {
        return dataRocket.name
    }

}
