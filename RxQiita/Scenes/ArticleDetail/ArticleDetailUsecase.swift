//
//  ArticleDetailUsecase.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/07/18.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import Foundation
import RxSwift
import QiitaAPIManager

protocol ArticleDetailUsecaseProtocol {
    func getArticleDetailStream() -> Observable<ArticleDetailModel>
    func updateArticleDetail()
}

final class ArticleDetailUsecase {

    private let qiitaClient: QiitaClientProtocol
    private let mapper: ArticleDetailModelMapperProtocol
    private let id: String

    private let modelPublishSubject = PublishSubject<ArticleDetailModel>()
    private let disposeBag = DisposeBag()

    init(qiitaClient: QiitaClientProtocol, mapper: ArticleDetailModelMapperProtocol, id: String) {
        self.qiitaClient = qiitaClient
        self.mapper = mapper
        self.id = id
    }

    private func fetchArticle() {
        qiitaClient.getArticle(with: id)
            .map { [weak self] entity -> ArticleDetailModel? in
                return self?.mapper.transform(entity: entity)
            }
            .subscribe(onSuccess: { [weak self] model in
                guard let s = self, let model = model else { return }
                s.modelPublishSubject.onNext(model)
            }, onError: { error in
                // TODO:- needs error handling impl
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}

extension ArticleDetailUsecase: ArticleDetailUsecaseProtocol {
    func getArticleDetailStream() -> Observable<ArticleDetailModel> {
        return modelPublishSubject.asObservable()
    }

    func updateArticleDetail() {
        fetchArticle()
    }
}
