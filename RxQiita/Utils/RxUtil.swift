//
//  RxUtil.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/08/24.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import Foundation
import RxSwift

final class RxUtil {
    static func filterNil<T>(input: T?) -> Observable<T> {
        guard let input = input else {
            return Observable<T>.never()
        }
        return Observable<T>.just(input)
    }
}

