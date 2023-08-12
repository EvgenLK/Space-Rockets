//
//  TappedPageControl.swift
//  SpaceRockets
//
//  Created by Evgenii Kutasov on 08.08.2023.
//

import Foundation

protocol DelegateTappedPage: AnyObject {
    func didSelectPage(number: Int)
}

