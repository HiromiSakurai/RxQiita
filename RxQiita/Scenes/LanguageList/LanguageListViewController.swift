//
//  LanguageListViewController.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/07/31.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import UIKit
import PinLayout
import RxSwift
import RxCocoa

final class LanguageListViewController: UIViewController {

    private let viewModel: LanguageListViewModelProtocol
    private let disposeBag = DisposeBag()

    private lazy var languageListTableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 48.0
        return table
    }()

    private let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)

    init(viewModel: LanguageListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Language List"
        navigationItem.leftBarButtonItem = cancelButton
        bindViewModel()
        setupTableVeiw()
        setupViewAction()
        setupLayout()
    }

    private func bindViewModel() {
        // swiftlint:disable opening_brace
        viewModel.getLanguageList()
            .drive(languageListTableView.rx.items(cellIdentifier: LanguageListTableCell.reuseIdentifier,
                                                  cellType: LanguageListTableCell.self))
            { _, element, cell in
                cell.config(language: element)
            }
            .disposed(by: disposeBag)
    }

    private func setupTableVeiw() {
        languageListTableView.register(LanguageListTableCell.self)
    }

    func setupViewAction() {
        cancelButton.rx.tap
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }

    private func setupLayout() {
        view.addSubview(languageListTableView)
        languageListTableView.pin.all(view.pin.safeArea)
    }
}
