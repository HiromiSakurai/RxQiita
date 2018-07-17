//
//  String+extensions.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/07/13.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let formmater = DateFormatter()
        formmater.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy-MM-dd'T'HH:mm:ssZZZZZ",
                                                        options: 0,
                                                        locale: Locale(identifier: "en_US_POSIX"))
        return formmater.date(from: self)
    }
}

extension Optional where Wrapped == String {
    var nonNil: String {
        if let s = self {
            return s
        } else {
            return ""
        }
    }
}
