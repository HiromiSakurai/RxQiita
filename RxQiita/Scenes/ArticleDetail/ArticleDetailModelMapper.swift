//
//  ArticleDetailModelMapper.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/07/18.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import Foundation
import QiitaAPIManager

final class ArticleDetailModelMapper {

    func transform(entity: Article) -> ArticleDetailModel {
        return ArticleDetailModel(id: entity.id, url: entity.url)
    }
}
