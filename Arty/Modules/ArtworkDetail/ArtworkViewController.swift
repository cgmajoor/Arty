//
//  ArtworkViewController.swift
//  Arty
//
//  Created by Ceren Gazioglu Majoor on 21/02/2022.
//

import UIKit
import Resolver
import SDWebImage

class ArtworkViewController: UIViewController {

    // MARK: - Dependencies

    @Injected private var viewModel: ArtworkViewModel

    // MARK: - Properties
    let objectNumber: String

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .green
        label.textAlignment = .center
        label.text = ""
        return label
    }()

    private var activityIndicatorView = UIActivityIndicatorView(style: .large)

    // MARK: - Init

    init(objectNumber: String) {
        self.objectNumber = objectNumber
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        getArtwork(objectNumber)
    }

    // MARK: - Fetch data

    private func getArtwork(_ objectNumber: String) {
        viewModel.fetchArtworkDetail(objectNumber) { [weak self] result  in
            guard let self = self else { return }

            DispatchQueue.main.async {
                switch result {
                case .loading:
                    self.activityIndicatorView.startAnimating()
                case .finished(let outcome):
                    self.activityIndicatorView.stopAnimating()
                    switch outcome {
                    case .success(let artworkDetail):
                        self.titleLabel.text = artworkDetail.title
                        guard let url = URL(string: artworkDetail.imageUrl) else { return }
                        self.imageView.sd_setImage(with: url, completed: nil)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }

    // MARK: - Private
    private func setup() {
        view.embed(view: stackView, insets: UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10))
        [imageView, titleLabel].forEach {
            stackView.addArrangedSubview($0)
        }
    }

}
