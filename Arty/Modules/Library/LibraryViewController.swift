//
//  LibraryViewController.swift
//  Arty
//
//  Created by Ceren Gazioglu Majoor on 10/02/2022.
//

import UIKit
import Resolver

class LibraryViewController: UIViewController {

    // MARK: - Dependencies

    @Injected private var viewModel: LibraryViewModel

    // MARK: - UI

    private var activityIndicatorView = UIActivityIndicatorView(style: .large)

    private lazy var collectionView: UICollectionView = {
        let collectionView  = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.backgroundColor = .blue
        return collectionView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Collection"

        setup()

        getCollection()
    }

    // MARK: - Private

    private func setup() {
        view.backgroundColor = .black
        view.embedToSafeArea(view: collectionView)

        [activityIndicatorView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        setupLayoutConstraints()
    }

    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func getCollection() {

        viewModel.fetchCollection { [weak self] result  in
            guard let self = self else { return }

            switch result {
            case .loading:
                self.activityIndicatorView.startAnimating()
            case .finished(let outcome):
                self.activityIndicatorView.stopAnimating()
                switch outcome {
                case .success(let getCollectionResponse):
                    print("Success! Artobjects count \(getCollectionResponse.artObjects.count)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    // MARK: - Actions

    @objc private func onTapFetchNextPage() {
        getCollection()
        print("Current page: \(viewModel.currentPage)")
    }
}
