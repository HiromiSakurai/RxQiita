//
//  ArticleListViewModel.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/07/26.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// TODO:- move to somewhere
struct ArticleListTableCellModel {
    let id: String
    let title: String
    let contributor: String
    let likesCount: String
    let createdAt: String
}

protocol ArticleListViewModelProtocol {
    func getArticleListStream() -> Signal<[ArticleListTableCellModel]>
    func updateArticleList(searchQuery: String, isAdditional: Bool)
}

final class ArticleListViewModel {

    private let usecase: ArticleListUsecaseProtocol
    private let mapper: ArticleListViewModelMapper

    private let disposeBag = DisposeBag()

    init(usecase: ArticleListUsecaseProtocol, mapper: ArticleListViewModelMapper) {
        self.usecase = usecase
        self.mapper = mapper
    }
}

extension ArticleListViewModel: ArticleListViewModelProtocol {

    func getArticleListStream() -> Signal<[ArticleListTableCellModel]> {
        return usecase.getArticleListStream()
            .map { [weak self] model -> [ArticleListTableCellModel] in
                guard let weakSelf = self else { return [] }
                return weakSelf.mapper.transform(model: model)
            }
            .asSignal(onErrorJustReturn: [])
    }

    func updateArticleList(searchQuery: String, isAdditional: Bool) {
        usecase.updateArticleList(searchQuery: searchQuery, isAdditional: isAdditional)
    }
}
