//
//  ArticleListViewModelMapper.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/07/26.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import Foundation

final class ArticleListViewModelMapper {

    func transform(model: ArticleListModel) -> [ArticleListTableCellModel] {
        guard let articles = model.articles else { return [] }
        return articles.map { article -> ArticleListTableCellModel in
            return ArticleListTableCellModel(id: article.id,
                                             title: article.title ?? "",
                                             contributor: article.contributor?.name ?? "",
                                             createdAt: stringFrom(date: article.createdAt))

        }
    }

    private func stringFrom(date: Date?) -> String {
        guard let d = date else { return "" }
        return String(d.year) + "/" + String(d.month) + "/" + String(d.month)
    }
}

// TODO:- move to somewhere
struct ArticleListTableCellModel {
    let id: String
    let title: String
    let contributor: String
    let createdAt: String
}
