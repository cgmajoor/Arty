//
//  ArtCardView.swift
//  Arty
//
//  Created by Ceren Gazioglu Majoor on 11/02/2022.
//

import UIKit

class ArtCardView: UIView {

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .green
        label.textAlignment = .left
        return label
    }()

    init(title: String = "", image: UIImage? = nil) {
        super.init(frame: .zero)
        setup()

        imageView.image = image
        titleLabel.text = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private
    private func setup() {
        clipsToBounds = true
        layer.masksToBounds = true

        [imageView, titleLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

        setupLayoutConstraints()
    }

    private func setupLayoutConstraints() {
        embed(view: imageView)
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: titleLabel.font.lineHeight)
        ])
    }

}
