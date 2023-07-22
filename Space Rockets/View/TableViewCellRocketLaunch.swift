//
//  TableViewCell.swift
//  SpaceRockets
//
//  Created by Evgenii Kutasov on 19.07.2023.
//

import UIKit
import SnapKit

class TableViewCellRocketLaunch: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(nameRocketLabel)
        addSubview(dateLaunchRocketLabel)
        addSubview(imageLaunchRocketLabel)
        constraintsCell()
    }
    
    let nameRocketLabel: UILabel = {
        let nameRocketLabel = UILabel()
        nameRocketLabel.font = UIFont(name: "Lab Grotesque", size: 20.0)
        nameRocketLabel.textColor = .white
        nameRocketLabel.text = "Rocket"
        return nameRocketLabel
    }()
    
    let dateLaunchRocketLabel: UILabel = {
        let dateLaunchRocketLabel = UILabel()
        dateLaunchRocketLabel.font = UIFont(name: "Lab Grotesque", size: 16.0)
        dateLaunchRocketLabel.textColor = .white
        dateLaunchRocketLabel.text = "01 01 1990"
        return dateLaunchRocketLabel
    }()
    
    let imageLaunchRocketLabel: UIImageView = {
        let imageLaunchRocketLabel = UIImageView()
        imageLaunchRocketLabel.image = UIImage(named: "rocket24")
        return imageLaunchRocketLabel
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constraintsCell() {
        
        nameRocketLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().offset(24)
            make.bottom.lessThanOrEqualToSuperview().offset(-24)
        }
        
        dateLaunchRocketLabel.snp.makeConstraints { make in
            make.top.equalTo(nameRocketLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().offset(-24)
        }
        
        imageLaunchRocketLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(34)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(32)
            make.width.equalTo(32)
        }
    }
    func congifure(with rocket: CustomCellModel) {
        nameRocketLabel.text = rocket.name
        dateLaunchRocketLabel.text = rocket.date
        imageLaunchRocketLabel.image = UIImage(named: rocket.image)
    }
}