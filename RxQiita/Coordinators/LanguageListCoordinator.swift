//
//  LanguageListCoordinator.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/08/01.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

enum LanguageListCoordinationResult {
    case language(String)
    case cancel
}

final class LanguageListCoordinator: BaseCoordinator<LanguageListCoordinationResult> {

    private let rootViewController: UIViewController

    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }

    override func start() -> Observable<LanguageListCoordinationResult> {
        let vc = resolver.resolve(LanguageListViewController.self)
        // swiftlint:disable:next force_unwrapping
        let navCon = UINavigationController(rootViewController: vc!)
        rootViewController.present(navCon, animated: true)
        return Observable.never()
    }
}
