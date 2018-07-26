//
//  Date+extensions.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/07/26.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import Foundation

extension Date {
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }

    var month: Int {
        return Calendar.current.component(.month, from: self)
    }

    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
}
