//
//  UserListCell.swift
//  gitparser
//
//  Created by andrey rulev on 12/24/17.
//  Copyright © 2017 andrey rulev. All rights reserved.
//

import UIKit

class UserListCell: UITableViewCell {
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
    
    var user: MDUser? {
        didSet {
            
        }
    }
    
    @IBOutlet fileprivate weak var loginLabel: UILabel!
    @IBOutlet fileprivate weak var idLabel: UILabel!
    @IBOutlet fileprivate weak var avatarImage: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        loginLabel.text = nil
        idLabel.text = nil
    }
}
