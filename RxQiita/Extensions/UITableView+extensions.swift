//
//  UITableViewView+extensions.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/07/31.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) where T: ReuseIdentifying {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func register<T: UITableViewHeaderFooterView>(_: T.Type) where T: ReuseIdentifying {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCellWithIdentifier<T: UITableViewCell>(indexPath: IndexPath) -> T where T: ReuseIdentifying {
        // swiftlint:disable:next force_cast
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}
