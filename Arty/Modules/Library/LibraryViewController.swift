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
    private lazy var fetchNextPage: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 5
        button.setTitle("Fetch Next Page", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(onTapFetchNextPage), for: .touchUpInside)
        return button
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

        [activityIndicatorView, fetchNextPage].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        setupLayoutConstraints()
    }

    private func setupLayoutConstraints() {
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        fetchNextPage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fetchNextPage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        fetchNextPage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        fetchNextPage.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
