//
//  ViewModelAssembly.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/07/27.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import Foundation
import Swinject

final class ViewModelAssembly {
    func assemble(container: Container) {
        registerViewModel(container: container)
        registerViewModelMapper(container: container)
    }

    func registerViewModel(container: Container) {
        container.register(ArticleListViewModelProtocol.self) { (_, usecase: ArticleListUsecaseProtocol, mapper: ArticleListViewModelMapperProtocol) in
            ArticleListViewModel(usecase: usecase, mapper: mapper)
        }
    }

    func registerViewModelMapper(container: Container) {
        container.register(ArticleListViewModelMapperProtocol.self) { _ in
            ArticleListViewModelMapper()
        }
    }
}
