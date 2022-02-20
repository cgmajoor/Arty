//
//  LibraryViewController.swift
//  Arty
//
//  Created by Ceren Gazioglu Majoor on 10/02/2022.
//

import UIKit
import Resolver

class LibraryViewController: UIViewController, UICollectionViewDelegate {

    // MARK: - Dependencies

    @Injected private var viewModel: LibraryViewModel

    // MARK: - Properties
    static let headerElementKind = "header-element-kind"

    var dataSource: UICollectionViewDiffableDataSource<Section, Artwork>! = nil

    private var loading: Bool = false

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

        getCollection(.print)
        getCollection(.drawing)
        getCollection(.painting)
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
        configureDataSource()
    }

    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.register(ArtworkCell.self, forCellWithReuseIdentifier: String(describing: ArtworkCell.self))
        collectionView.register(LibraryHeaderView.self,
                                forSupplementaryViewOfKind: String(describing: LibraryViewController.headerElementKind),
                                withReuseIdentifier: String(describing: LibraryHeaderView.self))
    }

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Artwork>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, artwork: Artwork) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ArtworkCell.self),
                                                                for: indexPath) as? ArtworkCell else {
                fatalError("Unable to dequeue ArtworkCell)")
            }
            cell.configure(artwork: artwork)
            return cell
        }

        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                      withReuseIdentifier: String(describing: LibraryHeaderView.self),
                                                                                      for: indexPath) as? LibraryHeaderView else {
                fatalError("Unable to dequeue LibraryHeaderView)")
            }

            sectionHeader.configure(title: Section.allCases[indexPath.section].rawValue)
            return sectionHeader
        }

    }

    // MARK: - Fetch data

    private func getCollection(_ section: Section) {
        viewModel.fetchCollection(section) { [weak self] result  in
            guard let self = self else { return }
            self.loading = true

            DispatchQueue.main.async {
                switch result {
                case .loading:
                    self.activityIndicatorView.startAnimating()
                case .finished(let outcome):

                    self.activityIndicatorView.stopAnimating()
                    self.loading = false
                    switch outcome {
                    case .success(let getCollectionResponse):

                        var snapshot = NSDiffableDataSourceSnapshot<Section, Artwork>()

                        for sec in Section.allCases {
                            snapshot.appendSections([sec])
                            snapshot.appendItems(self.viewModel.getArtworks(sec), toSection: sec)
                            // print("Success! Artobjects count \(self.viewModel.getArtworks(sec).count))")
                        }

                        self.dataSource?.apply(snapshot)

                    case .failure(let error):
                        print(error.localizedDescription)
                    }

                }
            }
        }
    }

    // MARK: - UICollectionViewLayout

    func createLayout() -> UICollectionViewLayout {

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 10

        let layout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalWidth(2/3))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90),
                                                   heightDimension: .fractionalWidth(2/3))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehavior.continuous

            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: LibraryViewController.headerElementKind,
                alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]

            section.visibleItemsInvalidationHandler = { [weak self] visibleItems, _, _ in
                guard let self = self else { return }
                if !self.loading {
                    self.loading = true
                    // print("Curent section: \(Section.allCases[sectionIndex])")
                    // print("Current visible item indexPath.row: \(visibleItems.last?.indexPath.row)")
                    self.getCollection(Section.allCases[sectionIndex])
                }
            }

            return section

        }, configuration: config)
        return layout
    }
    
}
