//
//  ArticleListViewController.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/07/27.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import UIKit
import PinLayout
import RxSwift
import RxCocoa

final class ArticleListViewController: UIViewController {

    private struct Const {
        static let firstSearchQuery: String = "Swift"
    }

    // not 'private' to access in coordinator
    let viewModel: ArticleListViewModelProtocol
    private let dataSource = ArticleListTableDataSource()
    private let disposeBag = DisposeBag()

    private lazy var articleListTableView: UITableView = {
        let table = UITableView()
        //table.rowHeight = 100
        return table
    }()

    private let languageButton = UIBarButtonItem(barButtonSystemItem: .organize, target: nil, action: nil)

    init(viewModel: ArticleListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Post List"
        navigationItem.rightBarButtonItem = languageButton
        bindViewModel()
        setupTableView()
        setupLayout()
        viewModel.updateArticleList(searchQuery: Const.firstSearchQuery, isAdditional: false)
    }

    private func bindViewModel() {
        viewModel.getArticleListStream()
            .drive(articleListTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        languageButton.rx.tap
            .bind(to: viewModel.chooseLanguage)
            .disposed(by: disposeBag)

        dataSource.selectedCellModel
            .bind(to: viewModel.selectArticle)
            .disposed(by: disposeBag)

        // TODO: not work well😱
//        articleListTableView.rx.modelSelected(ArticleListTableCellModel.self)
//            .bind(to: viewModel.selectArticle)
//            .disposed(by: disposeBag)
    }

    private func setupTableView() {
        articleListTableView.delegate = dataSource
        articleListTableView.register(ArticleListTableCell.self)
    }

    private func setupLayout() {
        view.addSubview(articleListTableView)
        articleListTableView.pin.all(view.pin.safeArea)
    }
}
