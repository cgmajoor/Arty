//
//  ArtworkCell.swift
//  Arty
//
//  Created by Ceren Gazioglu Majoor on 11/02/2022.
//

import UIKit
import SDWebImage

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
        artCardView.titleLabel.text = artwork.title
        guard let url = URL(string: artwork.imageUrl) else { return }
        artCardView.imageView.sd_setImage(with: url, completed: nil)
    }

    // MARK: - Private

    private func setup() {
        backgroundColor = .purple
        contentView.embed(view: artCardView)
    }
}
