//
//  UserListViewModel.swift
//  gitparser
//
//  Created by andrey rulev on 12/24/17.
//  Copyright © 2017 andrey rulev. All rights reserved.
//

import ReactiveCocoa
import ReactiveSwift
import Result
import Moya

class UserListViewModel: NSObject {
    
    // MARK: Internal properties
    let reload: Signal<(), NoError>
    let showError: Signal<String, NoError>
    var loading: Property<Bool> { return Property(_loading) }
    let pushController: Signal<UIViewController, NoError>
    
    // MARK: Private properties
    private var users: [MDUser] = []
    private let provider: NetworkProvider<UserService>
    private let reloadObserver: Signal<(), NoError>.Observer
    private let showErrorObserver: Signal<String, NoError>.Observer
    private let _loading: MutableProperty<Bool> = MutableProperty(false)
    private let pushControllerObserver: Signal<UIViewController, NoError>.Observer
    
    // MARK: Lifecycle
    init(provider: NetworkProvider<UserService> = NetworkProvider<UserService>()) {
        self.provider = provider
        (reload, reloadObserver) = Signal.pipe()
        (pushController, pushControllerObserver) = Signal.pipe()
        (showError, showErrorObserver) = Signal.pipe()
        
        super.init()
    }
}

// MARK: Internal API
extension UserListViewModel {
    func loadUsers() {
        _loading.value = true
        provider.request(.contributors).start { [weak self] event in
            switch event {
            case let .value(response):
                do {
                    self?.users = try JSONDecoder().decode([MDUser].self, from: response.data)
                    self?.reloadObserver.send(value: ())
                    self?._loading.value = false
                } catch let error {
                    self?._loading.value = false
                    self?.showErrorObserver.send(value: error.localizedDescription)
                }
            case let .failed(error):
                self?.showErrorObserver.send(value: error.localizedDescription)
            case .interrupted:
                self?._loading.value = false
            default:
                break
            }
        }
    }
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
        
        let viewModel = UserDetailViewModel(user: user)
        let controller = UserDetailController(viewModel: viewModel)
        pushControllerObserver.send(value: controller)
    }
}
