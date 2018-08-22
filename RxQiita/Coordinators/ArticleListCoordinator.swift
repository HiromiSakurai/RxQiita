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
        let articleListVC = resolver.resolve(ArticleListViewController.self)!
        let navCon = UINavigationController(rootViewController: articleListVC)

        articleListVC.viewModel.outputs.showLanguageList
            .flatMap { [weak self] _ -> Observable<String?> in
                guard let `self` = self else { return .empty() }
                return self.showLanguageList(on: articleListVC)
            }
            .flatMap { result -> Observable<String> in
                guard let result = result else { return Observable.empty() }
                return Observable.just(result)
            }
            .subscribe(onNext: { result in
                articleListVC.viewModel.inputs.updateArticleList(searchQuery: result, isAdditional: false)
            })
            .disposed(by: disposeBag)

        articleListVC.viewModel.outputs.showArticle
            .flatMap { [weak self] id -> Observable<Void> in
                guard let `self` = self else { return .empty() }
                return self.showArticleDetail(on: articleListVC, id: id)
            }
            .subscribe()
            .disposed(by: disposeBag)

        window.makeKeyAndVisible()
        window.rootViewController = navCon
        return Observable.never()
    }

    private func showArticleDetail(on rootViewController: UIViewController, id: String) -> Observable<Void> {
        let articleDetailCoordinator = ArticleDetailCoordinator(rootViewController: rootViewController, id: id)
        return coordinate(to: articleDetailCoordinator)
    }

    private func showLanguageList(on rootViewController: UIViewController) -> Observable<String?> {
        let languageListCoordinator = LanguageListCoordinator(rootViewController: rootViewController)
        return coordinate(to: languageListCoordinator)
            .map { result in
                switch result {
                case .language(let lang):
                    return lang
                case .cancel:
                    return nil
                }
        }
    }
}
