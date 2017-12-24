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
    }
}

