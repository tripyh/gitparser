//
//  UserListViewModel.swift
//  gitparser
//
//  Created by andrey rulev on 12/24/17.
//  Copyright © 2017 andrey rulev. All rights reserved.
//

import Foundation

class UserListViewModel: NSObject {
    
    // MARK: Private properties
    private var users: [MDUser] = []
}

// MARK: Data Source
extension UserListViewModel {
    var numberOfRows: Int {
        return users.count
    }
    
    func user(at index: Int) -> MDUser? {
        guard 0..<users.count ~= index else {
            return nil
        }
        
        return users[index]
    }
    
    func selectRow(at index: Int) {
        guard let user = user(at: index) else {
            return
        }   
    }
}
