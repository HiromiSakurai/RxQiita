//
//  ArticleListModelMapper.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/07/17.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import Foundation
import QiitaAPIManager

protocol ArticleListModelMapperProtocol {
    func transform(articles: [Article]) -> ArticleListModel
}

final class ArticleListModelMapper: ArticleListModelMapperProtocol {

    func transform(articles: [Article]) -> ArticleListModel {
        let articles =  articles.map { article -> ArticleListModel.Article? in
            guard let id = article.id else { return nil }
            let contributor = ArticleListModel.Contributor(name: article.user?.name,
                                                           profileImageURL: article.user?.profileImageUrl)
            return ArticleListModel.Article(id: id,
                                            title: article.title,
                                            contributor: contributor,
                                            renderedBody: article.renderedBody,
                                            body: article.body,
                                            likesCount: article.likesCount,
                                            createdAt: article.createdAt.nonNil.toDate(),
                                            updatedAt: article.updatedAt.nonNil.toDate())
            }
            .compactMap { $0 }
        return ArticleListModel(articles: articles)
    }
}
