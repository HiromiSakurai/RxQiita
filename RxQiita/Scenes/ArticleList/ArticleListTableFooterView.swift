//
//  ArticleListTableFooterView.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/08/24.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import Foundation
import UIKit
import PinLayout

class ArticleListTableFooterView: UITableViewHeaderFooterView {

    private let spinner: UIActivityIndicatorView = {
        return UIActivityIndicatorView(activityIndicatorStyle: .gray)
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(spinner)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startAnimating() {
        spinner.startAnimating()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        spinner.pin.all()
    }
}

extension ArticleListTableFooterView: ReuseIdentifying {}
