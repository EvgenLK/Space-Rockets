//
//  ViewModelDateFormater.swift
//  SpaceRockets
//
//  Created by Evgenii Kutasov on 24.07.2023.
//

import Foundation

import Foundation

class ViewModelHelper {
    func formatDate(dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "d MMMM, yyyy"
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    func convertToMillions(inputNumber: Int) -> Double {
        let million = 1000000
        let result = Double(inputNumber) / Double(million)
        return result
    }
}
