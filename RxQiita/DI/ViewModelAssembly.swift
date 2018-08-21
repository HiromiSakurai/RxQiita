//
//  ViewModelAssembly.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/07/27.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import Foundation
import Swinject

final class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        registerViewModel(container: container)
        registerViewModelMapper(container: container)
    }

    private func registerViewModel(container: Container) {
        container.register(ArticleListViewModelProtocol.self) { (_, usecase: ArticleListUsecaseProtocol, mapper: ArticleListViewModelMapperProtocol) in
            ArticleListViewModel(usecase: usecase, mapper: mapper)
        }

        container.register(LanguageListViewModelType.self) { _ in
            LanguageListViewModel()
        }

        container.register(ArticleDetailViewModelProtocol.self) { (_, usecase: ArticleDetailUsecaseProtocol, mapper: ArticleDetailViewModelMapperProtocol) in
            ArticleDetailViewModel(usecase: usecase, mapper: mapper)
        }
    }

    private func registerViewModelMapper(container: Container) {
        container.register(ArticleListViewModelMapperProtocol.self) { _ in
            ArticleListViewModelMapper()
        }

        container.register(ArticleDetailViewModelMapperProtocol.self) { _ in
            ArticleDetailViewModelMapper()
        }
    }
}
