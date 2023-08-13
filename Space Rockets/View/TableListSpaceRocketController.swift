//
//  TableListSpaceRocketController.swift
//  SpaceRockets
//
//  Created by Evgenii Kutasov on 17.07.2023.
//

import UIKit

final class TableListSpaceRocketController: UITableViewController {
    
    var viewModelLaunchesList: ViewModelLaunchesList?
    var launchesList =  [LaunchesModel]()
    var viewHelper = ViewModelHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelLaunchesList = ViewModelLaunchesList()
        tableView.register(TableViewCellRocketLaunch.self, forCellReuseIdentifier: "cell")
        viewModelLaunchesList?.responseLaunchesList { launchesList in
            DispatchQueue.main.async {
                self.launchesList = launchesList
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.title = "Rocket"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .darkGray
        cell.layer.cornerRadius = 30
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launchesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCellRocketLaunch
        
        let launch = launchesList[indexPath.row]
        cell.congifure(with: CustomCellModel(name: launch.name, date: viewHelper.formatDateLaunches(launch.staticFireDateUTC), image: "\(launch.imageSuccess)"))
        
        cell.selectionStyle = .none
        cell.isUserInteractionEnabled = false
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 8
        
        return cell
    }
}
