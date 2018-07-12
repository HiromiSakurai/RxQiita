//
//  ArticleListUsecase.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/07/13.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import Foundation
import RxSwift
import QiitaAPIManager

protocol ArticleListUsecaseProtocol {
    func getArticleListStream() -> Observable<ArticleListModel?>
    func updateArticleList(searchQuery: String, page: Int)
}
