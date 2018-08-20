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

protocol ArticleListViewModelProtocol {
    func getArticleListStream() -> Driver<[ArticleListTableCellModel]>
    func updateArticleList(searchQuery: String, isAdditional: Bool)
    func fetchAdditionalArticlesIfNeeded(currentIndexPath: IndexPath)
    var chooseLanguage: PublishRelay<Void> { get }
    var showLanguageList: Observable<Void> { get }
    var selectArticle: PublishRelay<ArticleListTableCellModel> { get }
    var showArticle: Observable<String> { get }
}

final class ArticleListViewModel {
    private struct Const {
        static let firstSearchQuery: String = "Swift"
    }

    private let usecase: ArticleListUsecaseProtocol
    private let mapper: ArticleListViewModelMapperProtocol
    private var dataSource: [ArticleListTableCellModel]

    let chooseLanguage = PublishRelay<Void>()
    let showLanguageList: Observable<Void>
    let selectArticle = PublishRelay<ArticleListTableCellModel>()
    let showArticle: Observable<String>

    private let disposeBag = DisposeBag()

    init(usecase: ArticleListUsecaseProtocol, mapper: ArticleListViewModelMapperProtocol) {
        self.usecase = usecase
        self.mapper = mapper
        self.dataSource = []
        self.showLanguageList = chooseLanguage.asObservable()
        self.showArticle = selectArticle.asObservable().map { $0.id }
    }

    private func isLastItem(indexPath: IndexPath) -> Bool {
        return dataSource.count == indexPath.row + 1
    }
}

extension ArticleListViewModel: ArticleListViewModelProtocol {

    func getArticleListStream() -> Driver<[ArticleListTableCellModel]> {
        return usecase.getArticleListStream()
            .map { [weak self] model -> [ArticleListTableCellModel] in
                guard let weakSelf = self else { return [] }
                weakSelf.dataSource += weakSelf.mapper.transform(model: model)
                return weakSelf.dataSource
            }
            .asDriver(onErrorJustReturn: [])
    }

    func updateArticleList(searchQuery: String, isAdditional: Bool) {
        if !isAdditional { dataSource = [] }
        usecase.updateArticleList(searchQuery: searchQuery, isAdditional: isAdditional)
    }

    func fetchAdditionalArticlesIfNeeded(currentIndexPath: IndexPath) {
        guard isLastItem(indexPath: currentIndexPath) else { return }
        usecase.updateArticleList(searchQuery: "", isAdditional: true)
    }
}
