//
//  ArticleDetailViewModel.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/08/02.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ArticleDetailViewModelInputs {
    var pop: PublishRelay<Void> { get }
    func updateArticleDetail()
}

protocol ArticleDetailViewModelOutputs {
    func getArticleDetailURLStream() -> Driver<URL>
    var didPop: Observable<Void> { get }
}

protocol ArticleDetailViewModelType {
    var inputs: ArticleDetailViewModelInputs { get }
    var outputs: ArticleDetailViewModelOutputs { get }
}

//protocol ArticleDetailViewModelProtocol {
//    func getArticleDetailURLStream() -> Driver<URL>
//    func updateArticleDetail()
//    var pop: PublishRelay<Void> { get }
//    var didPop: Observable<Void> { get }
//}

final class ArticleDetailViewModel: ArticleDetailViewModelType, ArticleDetailViewModelInputs, ArticleDetailViewModelOutputs {

    private let usecase: ArticleDetailUsecaseProtocol
    private let mapper: ArticleDetailViewModelMapperProtocol

    let pop = PublishRelay<Void>()
    let didPop: Observable<Void>

    var inputs: ArticleDetailViewModelInputs { return self }
    var outputs: ArticleDetailViewModelOutputs { return self }

    init(usecase: ArticleDetailUsecaseProtocol, mapper: ArticleDetailViewModelMapperProtocol) {
        self.usecase = usecase
        self.mapper = mapper
        didPop = pop.asObservable()
    }

    func getArticleDetailURLStream() -> Driver<URL> {
        // swiftlint:disable:next force_unwrapping
        let defaultURL = URL(string: "https://qiita.com/")!
        return usecase.getArticleDetailStream()
            .map { [weak self] model -> URL in
                guard let `self` = self else { return defaultURL }
                return self.mapper.transform(model: model)
            }
            .asDriver(onErrorJustReturn: defaultURL)
    }

    func updateArticleDetail() {
        usecase.updateArticleDetail()
    }
}
