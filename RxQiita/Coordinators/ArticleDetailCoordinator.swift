//
//  ArticleDetailCoordinator.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/08/02.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

final class ArticleDetailCoordinator: BaseCoordinator<Void> {

    private let rootViewController: UIViewController
    private let id: String

    init(rootViewController: UIViewController, id: String) {
        self.rootViewController = rootViewController
        self.id = id
    }

    override func start() -> Observable<Void> {
        // swiftlint:disable force_unwrapping
        let articleDetailVC = resolver.resolve(ArticleDetailViewController.self, argument: id)!
        let navCon = rootViewController.navigationController!
        navCon.pushViewController(articleDetailVC, animated: true)
        return Observable.never()
    }
}
