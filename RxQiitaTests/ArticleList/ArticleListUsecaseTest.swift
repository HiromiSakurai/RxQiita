//
//  ArticleListUsecaseTest.swift
//  RxQiitaTests
//
//  Created by 櫻井寛海 on 2018/07/14.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import XCTest
import QiitaAPIManager
import RxSwift
@testable import RxQiita

class ArticleListUsecaseTest: XCTestCase {

    var qiitaClient: QiitaClient!
    var mapper: ArticleListModelMapperProtocol!

    var usecase: ArticleListUsecaseProtocol!

    let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
        qiitaClient = QiitaClient()
        mapper = ArticleListModelMapper()
        usecase = ArticleListUsecase(qiitaClient: qiitaClient, mapper: mapper)
    }

    override func tearDown() {
        qiitaClient = nil
        mapper = nil
        usecase = nil
        super.tearDown()
    }

    func testGetArticleListStream() {
        let exp = expectation(description: "get article list stream")
        usecase.getArticleListStream()
            .subscribe(onNext: { _ in
                exp.fulfill()
            }, onError: { error in
                XCTAssert(false, error.localizedDescription)
            })
            .disposed(by: disposeBag)
        usecase.updateArticleList(searchQuery: "swift", isAdditional: false)
        waitForExpectations(timeout: 3.0, handler: nil)
    }
}
