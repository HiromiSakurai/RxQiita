//
//  ArticleDetailViewController.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/08/02.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa
import PinLayout

class ArticleDetailViewController: UIViewController {

    let viewModle: ArticleDetailViewModelProtocol
    private let disposeBag = DisposeBag()

    private lazy var webView: WKWebView = {
        let wv = WKWebView()
        return wv
    }()

    init(viewModel: ArticleDetailViewModelProtocol) {
        self.viewModle = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupLayout()
        viewModle.updateArticleDetail()
    }

    private func bindViewModel() {
        viewModle.getArticleDetailURLStream()
            .drive(onNext: { [weak self] url in
                let urlRequest = URLRequest(url: url)
                self?.webView.load(urlRequest)
            })
            .disposed(by: disposeBag)
    }

    private func setupLayout() {
        view.addSubview(webView)
        webView.pin.all(view.pin.safeArea)
    }
}
