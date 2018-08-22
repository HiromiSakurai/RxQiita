//
//  ViewControllerAssembly.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/07/27.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//
// swiftlint:disable force_unwrapping

import Foundation
import UIKit
import Swinject
import QiitaAPIManager

final class ViewControllerAssembly: Assembly {
    func assemble(container: Container) {
        registerViewController(container: container)
    }

    private func registerViewController(container: Container) {
        container.register(ArticleListViewController.self) { _ in

            let apiClient = container.resolve(QiitaClientProtocol.self)!
            let modelMapper = container.resolve(ArticleListModelMapperProtocol.self)!
            let usecase = container.resolve(ArticleListUsecaseProtocol.self, arguments: apiClient, modelMapper)!
            let viewModelMapper = container.resolve(ArticleListViewModelMapperProtocol.self)!
            let viewModel = container.resolve(ArticleListViewModelProtocol.self, arguments: usecase, viewModelMapper)!
            return ArticleListViewController(viewModel: viewModel)
        }

        container.register(LanguageListViewController.self) { _ in
            let viewModel = container.resolve(LanguageListViewModelType.self)!
            return LanguageListViewController(viewModel: viewModel)
        }

        container.register(ArticleDetailViewController.self) { (_, id: String) in
            let apiClient = container.resolve(QiitaClientProtocol.self)!
            let modelMapper = container.resolve(ArticleDetailModelMapperProtocol.self)!
            let usecase = container.resolve(ArticleDetailUsecaseProtocol.self, arguments: apiClient, modelMapper, id)!
            let viewModelMapper = container.resolve(ArticleDetailViewModelMapperProtocol.self)!
            let viewModel = container.resolve(ArticleDetailViewModelType.self, arguments: usecase, viewModelMapper)!
            return ArticleDetailViewController(viewModel: viewModel)
        }
    }
}
