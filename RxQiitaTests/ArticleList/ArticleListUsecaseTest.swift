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

    var usecase: ArticleListUsecaseProtocol!

    let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
        qiitaClient = QiitaClient()
        usecase = ArticleListUsecase(qiitaClient: qiitaClient)
    }

    override func tearDown() {
        qiitaClient = nil
        usecase = nil
        super.tearDown()
    }

    func testGetArticleListStream() {
        let exp = expectation(description: "get article list stream")
        usecase.getArticleListStream()
            .subscribe(onNext: { model in
                print(model)
                exp.fulfill()
            }, onError: { error in
                XCTAssert(false, error.localizedDescription)
            })
            .disposed(by: disposeBag)
        usecase.updateArticleList(searchQuery: "swift", isAdditional: false)
        waitForExpectations(timeout: 3.0, handler: nil)
    }
}
