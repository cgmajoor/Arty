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

        [activityIndicatorView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        setupLayoutConstraints()
    }

    private func setupLayoutConstraints() {
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    private func getCollection() {
        activityIndicatorView.startAnimating()

        viewModel.fetchCollection { [weak self] _, _  in
            guard let self = self else { return }
            self.activityIndicatorView.stopAnimating()
            print("done")
        }
    }
}
