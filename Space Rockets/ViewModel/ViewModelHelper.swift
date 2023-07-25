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
        // Проверяем, что URL допустим
        guard let url = URL(string: urlString) else {
            print("Ошибка: Некорректный URL")
            return
        }
        
        // Создаем URLSession для выполнения запроса
        let session = URLSession.shared
        
        // Создаем задачу загрузки данных по URL
        let task = session.dataTask(with: url) { data, response, error in
            // Проверяем наличие ошибок и данных
            guard let data = data, error == nil else {
                print("Ошибка при загрузке изображения: \(error?.localizedDescription ?? "Неизвестная ошибка")")
                return
            }
            
            // Создаем объект UIImage из полученных данных
            if let image = UIImage(data: data) {
                // Выполняем обновление пользовательского интерфейса на главной очереди
                DispatchQueue.main.async {
                    // Устанавливаем изображение в UIImageView
                    imageView.image = image
                }
            } else {
                print("Ошибка: Не удалось создать изображение из полученных данных")
            }
        }
        
        // Запускаем задачу
        task.resume()
    }

//    // Пример использования функции
//    let urlString = "https://imgur.com/DaCfMsj.jpg"
//    let imageView = UIImageView()
//
//    loadImage(from: urlString, into: imageView)

}
