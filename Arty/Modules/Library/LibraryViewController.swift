//
//  LibraryViewController.swift
//  Arty
//
//  Created by Ceren Gazioglu Majoor on 10/02/2022.
//

import UIKit
import Resolver

class LibraryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    // MARK: - Dependencies

    @Injected private var viewModel: LibraryViewModel

    // MARK: - UI

    private var activityIndicatorView = UIActivityIndicatorView(style: .large)

    private lazy var collectionView: UICollectionView = {
        let collectionView  = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
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

        configureCollectionView()
    }

    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ArtworkCell.self, forCellWithReuseIdentifier: String(describing: ArtworkCell.self))
        collectionView.register(LibraryHeaderView.self,
                                forSupplementaryViewOfKind: String(describing: LibraryViewController.self),
                                withReuseIdentifier: String(describing: LibraryHeaderView.self))
    }

    // MARK: - Fetch data

    private func getCollection() {

        viewModel.fetchCollection { [weak self] result  in
            guard let self = self else { return }

            switch result {
            case .loading:
                self.activityIndicatorView.startAnimating()
            case .finished(let outcome):

                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                    switch outcome {
                    case .success(let getCollectionResponse):
                        print("Success! Artobjects count \(getCollectionResponse.artObjects.count)")

                        self.collectionView.reloadData()

                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }

    // MARK: - Actions

    @objc private func onTapFetchNextPage() {
        getCollection()
        print("Current page: \(viewModel.currentPage)")
    }

    // MARK: - UICollectionViewLayout

    func createLayout() -> UICollectionViewLayout {

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20

        let layout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalWidth(2/3))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90),
                                                   heightDimension: .fractionalHeight(0.4))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehavior.continuous

            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: String(describing: LibraryViewController.self),
                alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
            return section

        }, configuration: config)
        return layout
    }

    // MARK: - UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.artworks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ArtworkCell.self), for: indexPath) as? ArtworkCell else {
            return UICollectionViewCell()
        }
        let artwork = viewModel.artworks[indexPath.row]
        cell.configure(artwork: artwork)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: String(describing: LibraryViewController.self),
                                                                         withReuseIdentifier: String(describing: LibraryHeaderView.self),
                                                                         for: indexPath) as? LibraryHeaderView else {
                  return UICollectionReusableView()
              }
        view.configure(title: "All Artworks")
        return view
    }
}
