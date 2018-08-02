//
//  ArticleDetailViewModelMapper.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/08/02.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import Foundation

protocol ArticleDetailViewModelMapperProtocol {
    func transform(model: ArticleDetailModel) -> URL
}

final class ArticleDetailViewModelMapper: ArticleDetailViewModelMapperProtocol {
    func transform(model: ArticleDetailModel) -> URL {
        // swiftlint:disable:next force_unwrapping
        let defaultURL = URL(string: "https://qiita.com/")!
        guard let urlStr = model.url else { return defaultURL }
        guard let url = URL(string: urlStr) else { return defaultURL }
        return url
    }
}
