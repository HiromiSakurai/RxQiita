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
        label.textAlignment = .left
        label.numberOfLines = 2
        //label.backgroundColor = .red
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        //label.backgroundColor = .blue
        return label
    }()

    private lazy var likesCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        //label.backgroundColor = .green
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
        likesCountLabel.text = "👍 " + likesCount
        dateLabel.text = "🕰 " + date
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(likesCountLabel)
        titleLabel.pin.top().left().right().height(60).margin(10)
        dateLabel.pin.below(of: titleLabel, aligned: .right).width(titleLabel.frame.width / 3).height(20)
        likesCountLabel.pin.below(of: titleLabel).before(of: dateLabel).width(dateLabel.frame.width / 2).height(20)
    }
}
