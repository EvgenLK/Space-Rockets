//
//  TableListSpaceRocketController.swift
//  SpaceRockets
//
//  Created by Evgenii Kutasov on 17.07.2023.
//

import UIKit

class TableListSpaceRocketController: UITableViewController {
    
    private var viewModel: ViewModelTypeLaunches?
    var viewModelLaunchesList: ViewModelLaunchesList?
    var launchesList =  [LaunchesModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TableViewCellRocketLaunch.self, forCellReuseIdentifier: "cell")
        viewModelLaunchesList?.launchesListRocket
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.title = "Rocket"
    }
    
    

    
    // Mark: setup Table view and color
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .darkGray
        cell.layer.cornerRadius = 24
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelLaunchesList?.numberOfRows() ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCellRocketLaunch
   
        
        guard let launchesList = viewModelLaunchesList?.getLaunches() else { return cell }
        
        for item in launchesList {
            cell.congifure(with: CustomCellModel(name: item.name, date: item.staticFireDateUTC, image: "\(item.success)"))
        }
        
        cell.selectionStyle = .none
        cell.isUserInteractionEnabled = false
        
        return cell
    }
}
