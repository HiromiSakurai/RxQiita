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
        // swiftlint:disable:next force_unwrapping
        let vc = resolver.resolve(LanguageListViewController.self)!
        let navCon = UINavigationController(rootViewController: vc)

        let language = vc.viewModel.didSelectLanguage.map { LanguageListCoordinationResult.language($0) }
        let cancel = vc.viewModel.didCancel.map { _ in LanguageListCoordinationResult.cancel }
        rootViewController.present(navCon, animated: true)
        return Observable.merge(language, cancel)
            .take(1)
            .do(onNext: { [weak self] _ in
                self?.rootViewController.dismiss(animated: true)
            })
    }
}
