//
//  ExtansionCollectionView.swift
//  SpaceRockets
//
//  Created by Evgenii Kutasov on 26.07.2023.
//

import Foundation
import UIKit

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.width
        let numberOfItemsInRow: CGFloat = 3.5
        let spacingBetweenItems: CGFloat = 12 

        let totalSpacing = (numberOfItemsInRow - 1) * spacingBetweenItems
        let itemWidth = (collectionViewWidth - totalSpacing) / numberOfItemsInRow

        return CGSize(width: itemWidth, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return !viewRocketParamData.isEmpty ? 4 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        
        if let rocket = viewRocketParamData.first {

            dictionaryRocket["Высота"] = rocket.height
            dictionaryRocket["Диаметр"] = rocket.diameter
            dictionaryRocket["Масса"] = rocket.weight
            dictionaryRocket["Нагрузка"] = rocket.leo

            let key = ArrayRocketParam[indexPath.row]
            if let value = dictionaryRocket[key] {
                cell.configure(with: CustomCellParamRocket(number: value, parametr: key))
            }
        }
        return cell
    }

}

