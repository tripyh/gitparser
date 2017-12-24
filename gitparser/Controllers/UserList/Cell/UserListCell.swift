//
//  UserListCell.swift
//  gitparser
//
//  Created by andrey rulev on 12/24/17.
//  Copyright © 2017 andrey rulev. All rights reserved.
//

import UIKit
import AlamofireImage

class UserListCell: UITableViewCell {
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
    
    var user: MDUser? {
        didSet {
            loginLabel.text = user?.login
            
            if let validId = user?.id {
                idLabel.text = String(validId)
            }
            
            if let validLink = user?.avatarUrl,
                let validUrl = URL(string: validLink) {
                avatarImage.af_setImage(withURL: validUrl)
            }
        }
    }
    
    @IBOutlet fileprivate weak var loginLabel: UILabel!
    @IBOutlet fileprivate weak var idLabel: UILabel!
    @IBOutlet fileprivate weak var avatarImage: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        loginLabel.text = nil
        idLabel.text = nil
        avatarImage.af_cancelImageRequest()
        avatarImage.layer.removeAllAnimations()
        avatarImage.image = nil
    }
}
