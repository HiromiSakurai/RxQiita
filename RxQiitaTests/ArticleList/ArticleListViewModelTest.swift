//
//  ArticleListViewModelTest.swift
//  RxQiitaTests
//
//  Created by 櫻井寛海 on 2018/07/26.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import XCTest
@testable import RxQiita
import RxSwift
import RxCocoa

class ArticleListViewModelTest: XCTestCase {

    var usecase: ArticleListUsecaseProtocol!
    var mapper: ArticleListViewModelMapper!
    var viewModel: ArticleListViewModelProtocol!

    let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        usecase = ArticleListUsecaseMock()
        mapper = ArticleListViewModelMapper()
        viewModel = ArticleListViewModel(usecase: usecase, mapper: mapper)
    }
    
    override func tearDown() {
        usecase = nil
        mapper = nil
        viewModel = nil
        super.tearDown()
    }

    func test_get_article_list_and_update() {
        let exp = expectation(description: "get article list stream")
        viewModel.getArticleListStream()
            .emit(onNext: { _ in
                exp.fulfill()
            })
            .disposed(by: disposeBag)
        viewModel.updateArticleList(searchQuery: "test", isAdditional: true)
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}

fileprivate class ArticleListUsecaseMock: ArticleListUsecaseProtocol {

    private let dummySubject: PublishSubject = PublishSubject<ArticleListModel>()

    func getArticleListStream() -> Observable<ArticleListModel> {
        return dummySubject.asObservable()
    }

    func updateArticleList(searchQuery: String, isAdditional: Bool) {
        dummySubject.onNext(dummyModel())
    }

    private func dummyModel() -> ArticleListModel {
        return ArticleListModel(articles: nil)
    }
}
