//
//  UsecaseAssembly.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/07/27.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import Foundation
import Swinject
import QiitaAPIManager

final class UsecaseAssembly: Assembly {
    func assemble(container: Container) {
        registerUsecase(container: container)
        registerModelMapper(container: container)
        registerAPIClient(container: container)
    }

    private func registerUsecase(container: Container) {
        container.register(ArticleListUsecaseProtocol.self) { (_, apiClient: QiitaClientProtocol, mapper: ArticleListModelMapperProtocol) in
            ArticleListUsecase(qiitaClient: apiClient, mapper: mapper)
        }
    }

    private func registerModelMapper(container: Container) {
        container.register(ArticleListModelMapperProtocol.self) { _ in
            ArticleListModelMapper()
        }
    }

    private func registerAPIClient(container: Container) {
        container.register(QiitaClientProtocol.self) { _ in
            QiitaClient()
        }
    }
}
