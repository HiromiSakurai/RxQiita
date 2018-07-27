//
//  ArticleListTableCell.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/07/27.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import UIKit
import PinLayout

class ArticleListTableCell: UITableViewCell {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private lazy var likesCountLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(title: String, likesCount: String, date: String) {
        titleLabel.text = title
        likesCountLabel.text = likesCount
        dateLabel.text = date
    }

    private func setupLayout() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(likesCountLabel)
        titleLabel.pin.top().left().height(30).right()
        dateLabel.pin.below(of: titleLabel).right().height(20).width(100)
        likesCountLabel.pin.below(of: titleLabel).before(of: dateLabel).height(20).width(100)
    }
}
