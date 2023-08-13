//
//  CustomCollectionViewCell.swift
//  SpaceRockets
//
//  Created by Evgenii Kutasov on 25.07.2023.
//

import UIKit

final class CustomCollectionViewCell: UICollectionViewCell {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(myLabelNumber)
        contentView.addSubview(myLabelNameParametr)
        setupConstraints()
        contentView.backgroundColor = .darkGray
        contentView.layer.cornerRadius = 30
        setupConstraintsCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraintsCell() {
        contentView.snp.makeConstraints { make in
            make.height.equalTo(96)
            make.width.equalTo(103)
        }
    }
    
    private let myLabelNumber: UILabel = {
        let myLabelNumber = UILabel()
        myLabelNumber.translatesAutoresizingMaskIntoConstraints = false
        myLabelNumber.textColor = .white
        myLabelNumber.textAlignment = .center
        return myLabelNumber
    }()
    
    private let myLabelNameParametr: UILabel = {
        let myLabelNameParametr = UILabel()
        myLabelNameParametr.translatesAutoresizingMaskIntoConstraints = false
        myLabelNameParametr.textColor = .gray
        myLabelNameParametr.textAlignment = .center
        return myLabelNameParametr
    }()
    
    func setupConstraints() {
        
        myLabelNumber.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }
        
        myLabelNameParametr.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(52)
            make.left.equalToSuperview().offset(1)
            make.right.equalToSuperview().offset(-1)
        }
    }
    func configure(with parametr: CustomCellParamRocket) {
        myLabelNumber.text = parametr.number
        myLabelNameParametr.text = parametr.parametr
    }
}
