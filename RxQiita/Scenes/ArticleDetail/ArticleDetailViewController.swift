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

    private enum Const {
        enum ObserverKey {
            static let loading = "loading"
            static let estimatedProgress = "estimatedProgress"
        }
    }

    let viewModle: ArticleDetailViewModelType
    private let disposeBag = DisposeBag()

    private lazy var webView: WKWebView = {
        let wv = WKWebView()
        return wv
    }()

    private lazy var progressBar: UIProgressView = {
        let bar = UIProgressView()
        bar.frame = CGRect(x: 0, //swiftlint:disable:next force_unwrapping
                           y: self.navigationController!.navigationBar.frame.size.height - 2,
                           width: self.view.frame.size.width,
                           height: 10)
        bar.progressViewStyle = .bar
        return bar
    }()

    init(viewModel: ArticleDetailViewModelType) {
        self.viewModle = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupProgressBar()
        setupLayout()
        viewModle.inputs.updateArticleDetail()
    }

    private func bindViewModel() {
        viewModle.outputs.getArticleDetailURLStream()
            .drive(onNext: { [weak self] url in
                let urlRequest = URLRequest(url: url)
                self?.webView.load(urlRequest)
            })
            .disposed(by: disposeBag)
    }

    private func setupProgressBar() {
        let loadingObservable = webView.rx.observe(Bool.self, Const.ObserverKey.loading)
            .flatMap(RxUtil.filterNil)
            .share()

        loadingObservable
            .map { return !$0 }
            .observeOn(MainScheduler.instance)
            .bind(to: progressBar.rx.isHidden)
            .disposed(by: disposeBag)

        loadingObservable
            .bind(to: UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)

        webView.rx.observe(Double.self, Const.ObserverKey.estimatedProgress)
            .flatMap(RxUtil.filterNil)
            .map { return Float($0) }
            .observeOn(MainScheduler.instance)
            .bind(to: progressBar.rx.progress)
            .disposed(by: disposeBag)
    }

    private func setupLayout() {
        view.addSubview(webView)
        navigationController?.navigationBar.addSubview(progressBar)
        webView.pin.all(view.pin.safeArea)
    }
}
