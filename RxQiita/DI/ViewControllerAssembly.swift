//
//  ViewControllerAssembly.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/07/27.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import Foundation
import UIKit
import Swinject
import QiitaAPIManager

final class ViewControllerAssembly: Assembly {
    func assemble(container: Container) {
        registerViewController(container: container)
    }

    func registerViewController(container: Container) {
        container.register(ArticleListViewController.self) { _ in
            // swiftlint:disable force_unwrapping
            let apiClient = container.resolve(QiitaClientProtocol.self)!
            let modelMapper = container.resolve(ArticleListModelMapperProtocol.self)!
            let usecase = container.resolve(ArticleListUsecaseProtocol.self, arguments: apiClient, modelMapper)!
            let viewModelMapper = container.resolve(ArticleListViewModelMapperProtocol.self)!
            let viewModel = container.resolve(ArticleListViewModelProtocol.self, arguments: usecase, viewModelMapper)!
            let vc = ArticleListViewController(viewModel: viewModel)
            return vc
        }
    }
}
