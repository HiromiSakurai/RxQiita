//
//  ArticleDetailUsecaseTest.swift
//  RxQiitaTests
//
//  Created by 櫻井寛海 on 2018/07/18.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import XCTest
import QiitaAPIManager
import RxSwift
@testable import RxQiita

class ArticleDetailUsecaseTest: XCTestCase {

    var qiitaClient: QiitaClient!
    var mapper: ArticleDetailModelMapper!

    var usecase: ArticleDetailUsecaseProtocol!

    let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
        qiitaClient = QiitaClient()
        mapper = ArticleDetailModelMapper()
        usecase = ArticleDetailUsecase(qiitaClient: qiitaClient, mapper: mapper, id: "1f28531a1c58d9158896")
    }

    override func tearDown() {
        qiitaClient = nil
        mapper = nil
        usecase = nil
        super.tearDown()
    }

    func testGetArticleListStream() {
        let exp = expectation(description: "get article detail stream")
        usecase.getArticleDetailStream()
            .subscribe(onNext: { _ in
                exp.fulfill()
            }, onError: { error in
                XCTAssert(false, error.localizedDescription)
            })
            .disposed(by: disposeBag)
        usecase.updateArticleDetail()
        waitForExpectations(timeout: 3.0, handler: nil)
    }
}
