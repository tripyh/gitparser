//
//  UserListController.swift
//  gitparser
//
//  Created by andrey rulev on 12/24/17.
//  Copyright © 2017 andrey rulev. All rights reserved.
//

import UIKit

class UserListController: UIViewController {
    
    // MARK: Private properties
    private let viewModel: UserListViewModel
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: Lifecycle
    init(viewModel: UserListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: _) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: Configure
private extension UserListController {
    func configure() {
        navigationItem.title = "Contributors"
        tableView.register(UINib(nibName: "UserListCell", bundle: nil),
                           forCellReuseIdentifier: UserListCell.reuseIdentifier)
    }
}

// MARK: UITableViewDataSource
extension UserListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserListCell.reuseIdentifier,
                                                 for: indexPath) as! UserListCell
        cell.user = viewModel.user(at: indexPath.row)
        return cell
    }
}

// MARK: UITableViewDelegate
extension UserListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectRow(at: indexPath.row)
    }
}



