//
//  AppCoordinator.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/08/01.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

final class AppCoordinator: BaseCoordinator<Void> {

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    override func start() -> Observable<Void> {
        let articleListCoordinator = ArticleListCoordinator(window: window)
        return coordinate(to: articleListCoordinator)
    }
}
