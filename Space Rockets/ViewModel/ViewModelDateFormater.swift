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
    
    func convertToMillions(inputNumber: String) -> String {
        let million = 1000000
        guard let number = Double(inputNumber) else {
            return String(0.0)
        }
        let result = number / Double(million)
        return String(result)
    }
}
