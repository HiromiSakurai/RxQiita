//
//  ArticleListUsecase.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/07/13.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import Foundation
import RxSwift
import QiitaAPIManager

protocol ArticleListUsecaseProtocol {
    func getArticleListStream() -> Observable<ArticleListModel>
    func updateArticleList(searchQuery: String, isAdditional: Bool)
}

final class ArticleListUsecase {

    private struct Const {
        static let firstPageIndex: Int = 1
        static let nextPageIndex: Int = 2
        static let emptyStrig: String = ""
    }

    private let qiitaClient: QiitaClientProtocol
    private let mapper: ArticleListModelMapperProtocol

    private var currentQuery: String = Const.emptyStrig
    private var nextPage: Int = Const.nextPageIndex

    private let modelPublishSubject = PublishSubject<ArticleListModel>()
    private let disposeBag = DisposeBag()

    init(qiitaClient: QiitaClientProtocol, mapper: ArticleListModelMapperProtocol) {
        self.qiitaClient = qiitaClient
        self.mapper = mapper
    }

    private func fetchArticleList(searchQuery: String, isAdditional: Bool) {
        let query: String = isAdditional ? currentQuery : searchQuery
        let page: Int = isAdditional ? nextPage : Const.firstPageIndex
        qiitaClient.fetchArticles(searchQuery: query, page: page)
            .map { [weak self] articles -> ArticleListModel? in
                return self?.mapper.transform(articles: articles)
            }
            .subscribe(onSuccess: {[weak self] model in
                guard let model = model, let s = self else { return }
                s.modelPublishSubject.onNext(model)
                s.nextPage += 1
            }, onError: { error in
                print(error) // TODO: need impl error handling
            })
            .disposed(by: disposeBag)
    }
}

extension ArticleListUsecase: ArticleListUsecaseProtocol {
    func getArticleListStream() -> Observable<ArticleListModel> {
        return modelPublishSubject.asObservable()
    }

    func updateArticleList(searchQuery: String, isAdditional: Bool) {
        fetchArticleList(searchQuery: searchQuery, isAdditional: isAdditional)
    }
}
