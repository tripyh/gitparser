//
//  Reactive+UINavigationController.swift
//  gitparser
//
//  Created by andrey rulev on 12/24/17.
//  Copyright © 2017 andrey rulev. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

extension Reactive where Base: UINavigationController {
    public func pushViewController(animated: Bool) -> BindingTarget<UIViewController> {
        return makeBindingTarget { base, controller in
            let pushBlock = { [weak base] in
                _ = base?.pushViewController(controller, animated: animated)
            }
            
            if base.presentedViewController != nil {
                base.dismiss(animated: animated, completion: pushBlock)
            } else {
                pushBlock()
            }
        }
    }
}
