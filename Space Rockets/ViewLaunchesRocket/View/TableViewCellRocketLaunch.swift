//
//  TableViewCell.swift
//  SpaceRockets
//
//  Created by Evgenii Kutasov on 19.07.2023.
//

import UIKit
import SnapKit

final class TableViewCellRocketLaunch: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameRocketLabel)
        contentView.addSubview(dateLaunchRocketLabel)
        contentView.addSubview(imageLaunchRocketLabel)
        constraintsCell()
    }
    
    private let nameRocketLabel: UILabel = {
        let nameRocketLabel = UILabel()
        nameRocketLabel.font = UIFont(name: "Arial", size: 20.0)
        nameRocketLabel.textColor = .white
        nameRocketLabel.text = "Rocket"
        return nameRocketLabel
    }()
    
    private let dateLaunchRocketLabel: UILabel = {
        let dateLaunchRocketLabel = UILabel()
        dateLaunchRocketLabel.font = UIFont(name: "Lab Grotesque", size: 16.0)
        dateLaunchRocketLabel.textColor = .white
        dateLaunchRocketLabel.text = "01 01 1990"
        return dateLaunchRocketLabel
    }()
    
    private let imageLaunchRocketLabel: UIImageView = {
        let imageLaunchRocketLabel = UIImageView()
        return imageLaunchRocketLabel
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constraintsCell() {
        
        nameRocketLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().offset(24)
            make.bottom.lessThanOrEqualToSuperview().inset(24)
        }
        
        dateLaunchRocketLabel.snp.makeConstraints { make in
            make.top.equalTo(nameRocketLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().inset(24)
        }
        
        imageLaunchRocketLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(34)
            make.right.equalToSuperview().inset(32)
            make.height.width.equalTo(32)
        }
    }
    
    func congifure(with rocket: CustomCellModel) {
        nameRocketLabel.text = rocket.name
        dateLaunchRocketLabel.text = rocket.date
        imageLaunchRocketLabel.image = UIImage(named: "\(rocket.image)")
    }
}
