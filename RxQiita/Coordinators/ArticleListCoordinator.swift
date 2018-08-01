//
//  ArticleListCoordinator.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/08/01.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

final class ArticleListCoordinator: BaseCoordinator<Void> {

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    override func start() -> Observable<Void> {
        // swiftlint:disable:next force_unwrapping
        let nextVC = resolver.resolve(ArticleListViewController.self)!
        let navCon = UINavigationController(rootViewController: nextVC)
        window.makeKeyAndVisible()
        window.rootViewController = navCon
        return Observable.never()
    }
}
