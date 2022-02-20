//
//  ArtCardView.swift
//  Arty
//
//  Created by Ceren Gazioglu Majoor on 11/02/2022.
//

import UIKit

class ArtCardView: UIView {

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

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
        embed(view: stackView)
        [imageView, titleLabel].forEach {
            stackView.addArrangedSubview($0)
        }
    }

}
