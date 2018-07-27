//
//  ArticleListModelMapperTest.swift
//  RxQiitaTests
//
//  Created by 櫻井寛海 on 2018/07/17.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import XCTest
import QiitaAPIManager
@testable import RxQiita

class ArticleListModelMapperTest: XCTestCase {

    var mapper: ArticleListModelMapperProtocol!
    var entity: [Article]!
    
    override func setUp() {
        super.setUp()
        mapper = ArticleListModelMapper()
        entity = ModelFactory.create()
    }
    
    override func tearDown() {
        mapper = nil
        entity = nil
        super.tearDown()
    }

    func testTransform() {
        let model = mapper.transform(articles: entity)
        XCTAssertEqual(model.articles?.count, 2)
        let firstArticle = model.articles!.first!
        XCTAssertEqual(firstArticle.id, "1")
        XCTAssertEqual(firstArticle.title, "title")
        XCTAssertEqual(firstArticle.contributor?.name, "name")
        XCTAssertEqual(firstArticle.contributor?.profileImageURL, "profileImageUrl")
        XCTAssertEqual(firstArticle.renderedBody, "renderedBody")
        XCTAssertEqual(firstArticle.body, "body")
        XCTAssertEqual(firstArticle.likesCount, 20)
        XCTAssertNotNil(firstArticle.createdAt)
        XCTAssertNotNil(firstArticle.updatedAt)
    }

    enum ModelFactory {
        static func create() -> [Article] {
            let group = Group(createdAt: "2000-01-01T00:00:00+00:00",
                              id: 1,
                              name: "name",
                              private: false,
                              updatedAt: "2000-01-01T00:00:00+00:00",
                              urlName: "urlName")
            let tag = Tag(name: "name", versions: ["0.0.1"])
            let user = User(description: "description",
                            facebookId: "facebookId",
                            followeesCount: 10,
                            followersCount: 20,
                            githubLoginName: "githubLoginName",
                            id: "id",
                            itemsCount: 20,
                            linkedinId: "linkedinId",
                            location: "location",
                            name: "name",
                            organization: "organization",
                            permanentId: 1,
                            profileImageUrl: "profileImageUrl",
                            twitterScreenName: "twitterScreenName",
                            websiteUrl: "websiteUrl")
            let article =  Article(renderedBody: "renderedBody",
                                   body: "body",
                                   coediting: false,
                                   commentsCount: 10,
                                   createdAt: "2000-01-01T00:00:00+00:00",
                                   group: group,
                                   id: "1",
                                   likesCount: 20,
                                   private: false,
                                   reactionsCount: 30,
                                   tags: [tag, tag],
                                   title: "title",
                                   updatedAt: "2000-01-01T00:00:00+00:00",
                                   url: "test.com",
                                   user: user,
                                   pageViewCount: 40)
            return [article, article]
        }
    }
}
