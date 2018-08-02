//
//  ArticleDetailModelMapper.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/07/18.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import Foundation
import QiitaAPIManager

protocol ArticleDetailModelMapperProtocol {
    func transform(entity: Article) -> ArticleDetailModel
}

final class ArticleDetailModelMapper: ArticleDetailModelMapperProtocol {

    func transform(entity: Article) -> ArticleDetailModel {
        return ArticleDetailModel(id: entity.id, url: entity.url)
    }
}
