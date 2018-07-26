//
//  ArticleListModel.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/07/13.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import Foundation

struct ArticleListModel {

    let articles: [Article]?

    struct Article {
        let id: String
        let title: String?
        let contributor: Contributor?
        let renderedBody: String?
        let body: String?
        let likesCount: Int?
        let createdAt: Date?
        let updatedAt: Date?
    }

    struct Contributor {
        let name: String?
        let profileImageURL: String?
    }
}
