//
//  ArticleListViewModelMapperTest.swift
//  RxQiitaTests
//
//  Created by 櫻井寛海 on 2018/07/26.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import XCTest
@testable import RxQiita

class ArticleListViewModelMapperTest: XCTestCase {

    var model: ArticleListModel!
    var mapper: ArticleListViewModelMapper!
    
    override func setUp() {
        super.setUp()
        model = ModelFactory.make()
        mapper = ArticleListViewModelMapper()
    }
    
    override func tearDown() {
        model = nil
        mapper = nil
        super.tearDown()
    }

    func test_transform() {
        let tableCellModel = mapper.transform(model: model)
        XCTAssertEqual(tableCellModel.count, 2)
        XCTAssertEqual(tableCellModel.first?.id, "id")
        XCTAssertEqual(tableCellModel.first?.title, "title")
        XCTAssertEqual(tableCellModel.first?.contributor, "contributor")
    }

    enum ModelFactory {
        static func make() -> ArticleListModel {
            let contributor = ArticleListModel.Contributor(name: "contributor", profileImageURL: nil)
            let article = ArticleListModel.Article(id: "id",
                                                   title: "title",
                                                   contributor: contributor,
                                                   renderedBody: nil,
                                                   body: nil,
                                                   createdAt: nil,
                                                   updatedAt: nil)
            return ArticleListModel(articles: [article, article])
        }
    }
}
