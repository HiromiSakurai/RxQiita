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

protocol LanguageListViewModelProtocol {
    func getLanguageList() -> Driver<[String]>
    var selectLanguage: PublishRelay<String> { get }
    var didSelectLanguage: Observable<String> { get }
    var cancel: PublishRelay<Void> { get }
    var didCancel: Observable<Void> { get }
}

final class LanguageListViewModel {

    let selectLanguage = PublishRelay<String>()
    let didSelectLanguage: Observable<String>
    let cancel = PublishRelay<Void>()
    let didCancel: Observable<Void>

    init() {
        didSelectLanguage = selectLanguage.asObservable()
        didCancel = cancel.asObservable()
    }

    private func languageList() -> [String] {
        return ["Swift", "Objective-C", "Kotlin", "Java", "Python", "Ruby", "JavaScript"]
    }
}

extension LanguageListViewModel: LanguageListViewModelProtocol {
    func getLanguageList() -> Driver<[String]> {
        return Driver.just(languageList())
    }
}
