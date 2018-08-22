//
//  LanguageListViewModel.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/07/31.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol LanguageListViewModelInputs {
    var selectLanguage: PublishRelay<String> { get }
    var cancel: PublishRelay<Void> { get }
}
protocol LanguageListViewModelOutputs {
    func languageList() -> Driver<[String]>
    var didSelectLanguage: Observable<String> { get }
    var didCancel: Observable<Void> { get }
}
protocol LanguageListViewModelType {
    var inputs: LanguageListViewModelInputs { get }
    var outputs: LanguageListViewModelOutputs { get }
}

final class LanguageListViewModel: LanguageListViewModelType, LanguageListViewModelInputs, LanguageListViewModelOutputs {

    let didSelectLanguage: Observable<String>
    let didCancel: Observable<Void>
    let selectLanguage = PublishRelay<String>()
    let cancel = PublishRelay<Void>()

    var inputs: LanguageListViewModelInputs { return self }
    var outputs: LanguageListViewModelOutputs { return self }

    init() {
        self.didSelectLanguage = selectLanguage.asObservable()
        self.didCancel = cancel.asObservable()
    }

    func languageList() -> Driver<[String]> {
        return Driver.just(makeLanguageList)
    }

    private lazy var makeLanguageList: [String] = {
        return ["Swift", "Objective-C", "Kotlin", "Java", "Python", "Ruby", "JavaScript"]
    }()
}
