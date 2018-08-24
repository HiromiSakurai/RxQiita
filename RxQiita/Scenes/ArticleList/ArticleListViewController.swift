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
        static let tableCellHeight: CGFloat = 100
        static let tableFooterHeight: CGFloat = 44
    }

    // not 'private' to access in coordinator
    let viewModel: ArticleListViewModelType
    private let dataSource = ArticleListTableDataSource()
    private let disposeBag = DisposeBag()

    lazy var articleListTableView: UITableView = {
        let table = UITableView()
        table.tableFooterView = tableFooterView
        return table
    }()

    private lazy var tableFooterView: ArticleListTableFooterView = {
        let footer = ArticleListTableFooterView()
        footer.startAnimating()
        return footer
    }()

    private let languageButton = UIBarButtonItem(barButtonSystemItem: .organize, target: nil, action: nil)

    init(viewModel: ArticleListViewModelType) {
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
        viewModel.inputs.updateArticleList(searchQuery: Const.firstSearchQuery, isAdditional: false)
    }

    private func bindViewModel() {
        viewModel.outputs.getArticleListStream()
            .drive(articleListTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        languageButton.rx.tap
            .bind(to: viewModel.inputs.chooseLanguage)
            .disposed(by: disposeBag)

        // TODO: not work well😱
//        articleListTableView.rx.modelSelected(ArticleListTableCellModel.self)
//            .bind(to: viewModel.selectArticle)
//            .disposed(by: disposeBag)
    }

    private func setupTableView() {
        articleListTableView.delegate = self
        articleListTableView.register(ArticleListTableCell.self)
        articleListTableView.register(ArticleListTableFooterView.self)
    }

    private func setupLayout() {
        view.addSubview(articleListTableView)
        articleListTableView.pin.all(view.pin.safeArea)
        tableFooterView.pin.width(of: articleListTableView).height(Const.tableFooterHeight)
    }
}

extension ArticleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Const.tableCellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.inputs.selectArticle.accept(dataSource.items[indexPath.row])
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex {
            tableView.tableFooterView?.isHidden = false
            viewModel.inputs.fetchAdditionalArticlesIfNeeded(currentIndexPath: indexPath)
        }
    }
}
