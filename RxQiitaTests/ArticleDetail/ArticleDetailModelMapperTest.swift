//
//  ArticleDetailModelMapperTest.swift
//  RxQiitaTests
//
//  Created by 櫻井寛海 on 2018/07/18.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import XCTest
import QiitaAPIManager
@testable import RxQiita

class ArticleDetailModelMapperTest: XCTestCase {

    var mapper: ArticleDetailModelMapper!
    var entity: Article!
    
    override func setUp() {
        super.setUp()
        mapper = ArticleDetailModelMapper()
        entity = ModelFactory.create()
    }
    
    override func tearDown() {
        mapper = nil
        entity = nil
        super.tearDown()
    }

    func test_transform() {
        let model = mapper.transform(entity: entity)
        XCTAssertEqual(model.id, "articleId")
        XCTAssertEqual(model.url, "articleUrl")
    }

    enum ModelFactory {
        static func create() -> Article {
            return Article(renderedBody: nil,
                           body: nil,
                           coediting: nil,
                           commentsCount: nil,
                           createdAt: nil,
                           group: nil,
                           id: "articleId",
                           likesCount: nil,
                           private: nil,
                           reactionsCount: nil,
                           tags: nil,
                           title: nil,
                           updatedAt: nil,
                           url: "articleUrl",
                           user: nil,
                           pageViewCount: nil)
        }
    }
    
}
