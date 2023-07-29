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
        let numberOfItemsInRow: CGFloat = 3.5 // Количество элементов в одном ряду (может быть изменено по вашему выбору)
        let spacingBetweenItems: CGFloat = 12 // Расстояние между элементами (в данном случае - 12 пикселей)

        let totalSpacing = (numberOfItemsInRow - 1) * spacingBetweenItems
        let itemWidth = (collectionViewWidth - totalSpacing) / numberOfItemsInRow

        return CGSize(width: itemWidth, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModelparametrRocket.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        
        
        
        for rocket in viewRocketParamData {

            cell.configure(with: CustomCellParamRocket(number: "\(rocket.diameter)", parametr: "\(rocket.height)"))
        }
        
//        let rocket = parametrRocket[indexPath.row]
//        cell.configure(with: CustomCellParamRocket(number: "\(rocket.diameter)", parametr: "\(rocket.height)"))

        
        return cell
    }

}

