//
//  LanguageListTableCell.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/07/31.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import UIKit

class LanguageListTableCell: UITableViewCell {

    lazy var languageTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(language: String) {
        languageTitleLabel.text = language
    }
}

// MARK: Layout
extension LanguageListTableCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(languageTitleLabel)
        languageTitleLabel.pin.top().left(10.0).bottom().right()
    }
}

// MARK: ReuseIdentifying
extension LanguageListTableCell: ReuseIdentifying {}
