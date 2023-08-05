//
//  ViewModelDateFormater.swift
//  SpaceRockets
//
//  Created by Evgenii Kutasov on 24.07.2023.
//

import Foundation

import Foundation
import UIKit

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
    
    
    func loadImage(from urlString: String, into imageView: UIImageView) {
        guard let url = URL(string: urlString) else {
            print("Ошибка: Некорректный URL")
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Ошибка при загрузке изображения: \(error?.localizedDescription ?? "Неизвестная ошибка")")
                return
            }
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            } else {
                print("Ошибка: Не удалось создать изображение из полученных данных")
            }
        }
        
        task.resume()
    }
}
