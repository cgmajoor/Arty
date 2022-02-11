//
//  LibraryHeaderView.swift
//  Arty
//
//  Created by Ceren Gazioglu Majoor on 11/02/2022.
//

import UIKit

class LibraryHeaderView: UICollectionReusableView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(title: String) {
        titleLabel.text = title
    }

    // MARK: - Private
    private func setup() {
        backgroundColor = .yellow
        embed(view: titleLabel)
    }
}
