//
//  UserListController.swift
//  gitparser
//
//  Created by andrey rulev on 12/24/17.
//  Copyright © 2017 andrey rulev. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result
import MBProgressHUD

class UserListController: UIViewController {
    
    // MARK: Private properties
    private let viewModel: UserListViewModel
    @IBOutlet private weak var tableView: UITableView!
    private var refreshControl: UIRefreshControl!
    private let (lifetime, token) = Lifetime.make()
    
    private var showError: BindingTarget<String> {
        return BindingTarget(lifetime: lifetime, action: { [weak self] message in
            self?.showError(message)
        })
    }
    
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
        bindingViewModel()
        viewModel.loadUsers()
    }
}

// MARK: Configure
private extension UserListController {
    func configure() {
        navigationItem.title = "Contributors"
        tableView.register(UINib(nibName: "UserListCell", bundle: nil),
                           forCellReuseIdentifier: UserListCell.reuseIdentifier)
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTable),
                                 for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
    }
}

// MARK: Private API
private extension UserListController {
    @objc func refreshTable() {
        viewModel.loadUsers()
    }
    
    func showError(_ error: String) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.text
        hud.detailsLabel.text = error
        hud.hide(animated: true, afterDelay: 2)
    }
}

// MARK: Bind ViewModel
private extension UserListController {
    func bindingViewModel() {
        view.reactive.isUserInteractionEnabled <~ viewModel.loading.negate()
        tableView.reactive.reloadData <~ viewModel.reload
        refreshControl.reactive.isRefreshing <~ viewModel.loading
        showError <~ viewModel.showError
        
        if let nc = navigationController {
            nc.reactive.pushViewController(animated: true) <~ viewModel.pushController
        }
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



