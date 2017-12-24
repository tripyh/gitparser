//
//  UserDetailController.swift
//  gitparser
//
//  Created by andrey rulev on 12/24/17.
//  Copyright © 2017 andrey rulev. All rights reserved.
//

import UIKit
import AlamofireImage

class UserDetailController: UIViewController {
    
    // MARK: Private properties
    private let viewModel: UserDetailViewModel
    @IBOutlet fileprivate weak var avatarImage: UIImageView!
    @IBOutlet fileprivate weak var loginLabel: UILabel!
    
    // MARK: Lifecycle
    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: _) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginLabel.text = viewModel.user.login
        
        if let validLink = viewModel.user.avatarUrl,
            let validUrl = URL(string: validLink) {
            avatarImage.af_setImage(withURL: validUrl)
        }
    }
}
