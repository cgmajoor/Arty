//
//  ArtworkCell.swift
//  Arty
//
//  Created by Ceren Gazioglu Majoor on 11/02/2022.
//

import UIKit

class ArtworkCell: UICollectionViewCell {

    let artCardView = ArtCardView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(artwork: Artwork) {
        artCardView.titleLabel.text = artwork.artObject.title
    }

    // MARK: - Private

    private func setup() {
        backgroundColor = .purple
        contentView.embed(view: artCardView)
    }
}
